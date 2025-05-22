{ config, lib, pkgs, inputs, ... }:
{
  imports = 
    [
      ../nixos
      ./hardware-configuration.nix
    ];

  config.nixos = {
    username = "stefan";
    hostname = "form";
    wifi = false;
  };

  config = {
    hardware.graphics.enable = true;
    boot.initrd.kernelModules = [ "nvidia" "nvidia_uvm" "nvidia_drm" ];
    boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
    # boot.kernelParams = [];
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia = {
      modesetting.enable = true;
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
    hardware.opengl.extraPackages = with pkgs; [
      vaapiVdpau
    ];
  };
}
