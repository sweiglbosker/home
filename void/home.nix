{ inputs, config, lib, pkgs, ... }:
{
  imports = [
    ../modules/global.nix
    ../modules
  ];

  config.modules = {
    global = {
      notNixOS = true;
      wayland = true;

      extraPackages = with pkgs; [
        wmenu
        cmatrix
      ];
    };

    foot.enable = true;

    gpg.enable = true;

    neovim = {
      enable = true;
    };

    sway = {
      enable = true;
      terminal = "foot";
    };

    mako.enable = true;
    neovide.enable = true;

    services = {
      enable = true;
      coreServices = ["dbus"];
      services = {
        "pipewire" = {
          run = "${builtins.readFile ./services/pipewire/run}";
          log = "${builtins.readFile ./services/pipewire/log/run}";
        };
        "mpd" = {
          run = "${builtins.readFile ./services/mpd/run}";
        };
        "dbus" = {
          run = "${builtins.readFile ./services/dbus/run}";
          log = "${builtins.readFile ./services/dbus/log/run}";
        };
      };
    };
  };
}
