{ inputs, config, lib, pkgs, nixgl, ... }:
{
  imports = [
    ./modules/global.nix
    ./modules
  ];

  config.modules = {
    global = {
      notNixOS = true;
      wayland = true;

      extraPackages = with pkgs; [
        mako
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
  };
}
