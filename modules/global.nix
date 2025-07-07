{ config, lib, pkgs, inputs, ...}:
let
  cfg = config.modules.global;
  berkeley-mono = pkgs.callPackage ../packages/berkeley-mono.nix { inherit pkgs; };
  binaryninja = pkgs.callPackage ../packages/binaryninja.nix { inherit pkgs; };
  scheme = config.modules.scheme;
in
{
  imports = [ ./default.nix ];

  options.modules.global = with lib.options; {
    notNixOS = mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether nix is running outside of NixOS.";
    };
    wayland = mkEnableOption "Wayland";
    extraPackages = mkOption {
      type = with lib.types; listOf package;
      description = "List of extra packages to install";
      example = [ pkgs.cowsay pkgs.lolcat ];
      default = [];
    };
    menu = mkOption {
      type = lib.types.submodule {
        package = lib.types.package;
        dmenu = lib.mkOption {
          type = lib.types.pathInStore;
          description = "derivation that will behave like dmenu";
          example = pkgs.dmenu;
          default = pkgs.fuzzel;
        };
      };
    };
  };

  config = {
    modules = rec {
      global = {
        wayland = lib.mkDefault true;
      };
      firefox.enable = true;
      sway = {
        wrapWithNixGL = cfg.notNixOS;
      };
      qutebrowser = {
      	wrapWithNixGL = cfg.notNixOS;
      };
      email.enable = true;
      aerc.enable = true;
      zsh.enable = true;
      tmux.enable = true;
      fzf.enable = true;
      git.enable = true;
      lazygit.enable = true;
      fuzzel.enable = true;
      zathura.enable = true;
    };

    nixGL = lib.mkIf cfg.notNixOS {
        packages = inputs.nixgl.packages;
        defaultWrapper = "mesa";
    };

    programs = {
      home-manager.enable = true;
      direnv = {
        enable = true;
        enableZshIntegration = true;
        enableBashIntegration = true;
        silent = true;
      };
    };

    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "NotoMono Nerd Font Mono" ];
        sansSerif = [ "Noto Sans" ];
        serif = [ "Noto Serif" ];
        emoji = [ "Noto Color Emoji"];
      };
    };

    dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "${if scheme.light then "prefer-light" else "prefer-dark"}";
        };
      };
    };

    gtk = {
      enable = true;
      gtk3.extraConfig.gtk-application-prefer-dark-theme = if scheme.light then 0 else 1;
      gtk4.extraConfig.gtk-application-prefer-dark-theme = if scheme.light then 0 else 1;
      theme = {
        name = "${if scheme.light then "Adwaita" else "Adwaita-dark"}";
        # package = pkgs.gnome.gnome-themes-extra;
      };
    };

    qt = {
      platformTheme.name = "gnome";
      style = {
        package = pkgs.adwaita-qt;
        name = "${if scheme.light then "adwaita" else "adwaita-dark"}";
      };
    };

    targets.genericLinux.enable = cfg.notNixOS;

    home = {
      username = "stefan";
      homeDirectory = "/home/stefan";
      stateVersion = "24.11";
      shell.enableZshIntegration = true;

      sessionPath = [
        "$HOME/.local/opt/binaryninja/bin"
        "$HOME/scripts"
      ];

      packages = with pkgs; [
        eza
        fanwood
        jq
        ripgrep
        elan
        dmenu
        berkeley-mono
        binaryninja
        tamzen
        roboto
        roboto-serif
        cozette
        inter
        noto-fonts
        noto-fonts-extra
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-emoji
        material-icons
      ] ++ (builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts))
        ++ (lib.optional cfg.notNixOS nixgl.auto.nixGLDefault)
        ++ (lib.optionals cfg.wayland 
        [
          wl-clipboard
          #...
        ])
        ++ cfg.extraPackages;
    };

  };
}
