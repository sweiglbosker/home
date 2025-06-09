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
    wifi = true;
  };

  config = {
    hardware.graphics.enable = true;
    boot.initrd.kernelModules = [ "nvidia" "nvidia_uvm" "nvidia_drm" ];
    boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
    # boot.kernelParams = [];
    services.xserver.videoDrivers = ["nvidia"];
    services.desktopManager.plasma6.enable = true;
    services.displayManager.sddm = {
      enable = true;
    };
    services.xserver.enable = true;
    hardware.nvidia = {
      modesetting.enable = true;
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
    hardware.opengl.extraPackages = with pkgs; [
      vaapiVdpau
    ];

    virtualisation.docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
    nixos = {
      osu.enable = true;
    };
  };
}
