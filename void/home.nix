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
      services = {
        "pipewire" = {
          run = "${builtins.readFile ./services/pipewire/run}";
        };
        "mpd" = {
          run = "${builtins.readFile ./services/mpd/run}";
        };
      };
    };
  };
}
