{ inputs, config, lib, pkgs,  ... }:
{
  imports = [
    ./modules/global.nix
    ./modules
  ];

  config.modules = {
    foot.enable = true;
  };
}
