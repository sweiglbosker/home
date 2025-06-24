{ inputs, config, lib, pkgs, ... }:
{
  imports = [
    ../modules/global.nix
    ../modules
  ];

  config = {
    home.pointerCursor = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
      size = 24;
      x11 = {
        enable = true;
        defaultCursor = "Adwaita";
      };
    };
  };
  config.modules = {
    global = {
      wayland = true;
  
      extraPackages = with pkgs; [
        wmenu
        cmatrix
        wayneko
        pfetch
        nicotine-plus
        mpc
      ];
    };

    colors.mountain.enable = true;
    # colors.tomorrow.enable = true;
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

    i3status = {
      enable = true;
      wireless = true;
      battery = true;
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
