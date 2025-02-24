{ inputs, config, lib, pkgs, nixgl, ... }:
{
  imports = [
    ./modules/global.nix
    ./modules
  ];

  config.modules = {
    global = {
      notNixOS = true;
    };
    foot.enable = true;


    neovim = {
      enable = true;
    };
#    sway = {
#        enable = true;
#    };
  };
}
