{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.nixos;
in
{
  options.nixos.libvirt = {
    enable = lib.mkEnableOption "libvirt";
  };
  config = lib.mkIf config.nixos.libvirt.enable {
    programs.virt-manager.enable = true;
    users.groups.libvirtd.members = [ "${cfg.username}" ];
    virtualisation.libvirtd = {
      enable = true;
      qemu.vhostUserPackages = [ pkgs.virtiofsd ];
    };
    virtualisation.spiceUSBRedirection.enable = true;
  };
}
