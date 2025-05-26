{ config, lib, pkgs, inputs, ... }:
{
  options.nixos.osu = {
    enable = lib.mkEnableOption "osu!";
  };
  config = lib.mkIf config.nixos.osu.enable {
    hardware.opentabletdriver.enable = true;
    environment.systemPackages = [ pkgs.osu-lazer-bin ];
  };
}
