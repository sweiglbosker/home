{ inputs, config, lib, pkgs, ... }:
{
  imports = [
    ../modules/global.nix
    ../modules
  ];

  config.modules = {
    global = {
      wayland = true;
  
      extraPackages = with pkgs; [
        wmenu
        cmatrix
        wayneko
        pfetch
      ];
    };

    gpg.enable = true;

    foot.enable = true;

    neovim = {
      enable = true;
    };

    sway = {
      enable = true;
      terminal = "foot";
    };

    qutebrowser = {
      enable = true;
    };

    mako.enable = true;
    neovide.enable = true;
    zsh.enable = true;
  };
}
