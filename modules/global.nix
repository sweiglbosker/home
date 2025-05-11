{ config, lib, pkgs, inputs, ...}:
let
  cfg = config.modules.global;
  berkeley-mono = pkgs.callPackage ../packages/berkeley-mono.nix { inherit pkgs; };
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
          default = pkgs.tofi;
        };
      };
    };
  };

  config = {
    modules = rec {
      global = {
        wayland = lib.mkDefault true;
      };
      sway = {
        wrapWithNixGL = cfg.notNixOS;
      };
      qutebrowser = {
      	wrapWithNixGL = cfg.notNixOS;
      };
      zsh.enable = true;
      tmux.enable = true;
      fzf.enable = true;
      git.enable = true;
      lazygit.enable = true;
      tofi.enable = true;
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
        nerd-fonts.comic-shanns-mono
        eza
        ripgrep
        elan
        dmenu
        berkeley-mono
        fanwood
      ] ++ (lib.optional cfg.notNixOS nixgl.auto.nixGLDefault)
        ++ (lib.optionals cfg.wayland 
        [
          wl-clipboard
          #...
        ])
        ++ cfg.extraPackages;
    };

  };
}
