{ config, lib, pkgs, ... }:
let
  cfg = config.nixos.bluetooth;
  inherit (lib) types mkOption;
in
{
  options.nixos.bluetooth = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "enable bluetooth support";
    };
  };

  config = lib.mkIf cfg.enable {
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;
  };
}
