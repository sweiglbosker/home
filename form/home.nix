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

    pass = {
      enable = true;
      key = "B5200ABFBD213FC9C17C6DB91291CBBCF3B9F225";
    };

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
    tofi.enable = true;
  };
}
