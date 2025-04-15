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
    colors.mountain.enable = true;
    # colors.default-dark.enable = true;
    # colors.tomorrow.enable = true;
    # colors.google-dark.enable = true;
    # colors.grayscale-dark.enable = true;
    # colors.grayscale-light.enable = true;
    gpg.enable = true;
    qutebrowser.enable = true;

    pass = {
      enable = true;
      key = "B5200ABFBD213FC9C17C6DB91291CBBCF3B9F225";
    };

    neovim = {
      enable = true;
    };

    sway = {
      enable = true;
      terminal = "footclient";
      startup = [
        {
          command = "foot -s";
          always = false;
        }
        {
          command = "avizo-service";
          always = false;
        }
        {
          # TODO: move to turnstile
          command = "tmux start-server";
          always = false;
        }
      ];
    };

    i3status = {
      enable = true;
      battery = true;
      wireless = true;
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
        "mpdscribble" = {
          run = "${builtins.readFile ./services/mpdscribble/run}";
        };
        "dbus" = {
          run = "${builtins.readFile ./services/dbus/run}";
          log = "${builtins.readFile ./services/dbus/log/run}";
        };
      };
    };
  };
}
