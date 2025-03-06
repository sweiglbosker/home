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

    pass = {
      enable = true;
      key = "B5200ABFBD213FC9C17C6DB91291CBBCF3B9F225";
    };

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
