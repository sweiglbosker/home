{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.pass;

  inherit (lib)
    mkEnableOption
    mkOption
    mkIf
    types
    ;
in
{
  options.modules.pass = {
    enable = mkEnableOption "pass";
    enableExtensions = mkEnableOption "extensions";
    key = mkOption {
      type = types.nullOr types.str;
      description = "gpg key, spaces forbidden";
      default = "";
    };
    wmenu = mkOption {
      type = types.str;
      description = "dmenu command to use for passmenu in a wayland session";
      default = "fuzzel --dmenu --layer=overlay";
    };
    xmenu = mkOption {
      type = types.str;
      description = "dmenu command to use for passmenu in an x session";
      default = "dmenu";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      (writeShellScriptBin "passmenu" ''
        shopt -s nullglob globstar

        if [[ -n $WAYLAND_DISPLAY ]]; then
          menu="${cfg.wmenu}"
        elif [[ -n $DISPLAY ]]; then
          menu="${cfg.xmenu}" # fallback to dmenu if running under x11
        else
          echo "Error: No Wayland or X11 display detected" >&2
          exit 1
        fi

        prefix=''${PASSWORD_STORE_DIR-~/.password-store}
        password_files=( "$prefix"/**/*.gpg )
        password_files=( "''${password_files[@]#"$prefix"/}" )
        password_files=( "''${password_files[@]%.gpg}" )

        password=$(printf '%s\n' "''${password_files[@]}" | $menu "$@")

        [[ -n $password ]] || exit

        pass show -c "$password" 2>/dev/null
      '')
    ];
    programs.password-store = {
      package = pkgs.pass.override {
        dmenuSupport = false;
      };
      enable = true;
      settings = {
        PASSWORD_STORE_DIR = "${config.home.homeDirectory}/.password-store";
        PASSWORD_STORE_CHARACTER_SET = ''[:alnum:]*!@^&_\-=[]|;~,./?'';
        PASSWORD_STORE_CLIP_TIME = "25";
        PASSWORD_STORE_KEY = cfg.key;
        PASSWORD_STORE_ENABLE_EXTENSIONS = if cfg.enableExtensions then "1" else "0";
      };
    };
  };
}
