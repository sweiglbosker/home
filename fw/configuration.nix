{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../nixos
    ./hardware-configuration.nix
  ];

  config.nixos = {
    username = "stefan";
    hostname = "fw";
    yubikey.enable = true;
  };

  config = {
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    services.openssh.enable = true;

    services.xserver = {
      enable = true;
      displayManager = {
        defaultSession = "sway";
        gdm.enable = true;
      };
      desktopManager.gnome.enable = true;
    };

    services.kmonad = {
      enable = false;
      keyboards = {
        internal = {
          device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
          defcfg.enable = true;
          config = builtins.readFile ../kmonad/miryoku.kbd;
        };
      };
    };

    users.users."stefan".extraGroups = [
      "input"
      "uinput"
      "video"
    ]; # TODO: remove

    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        rocmPackages.clr.icd
      ];
    };

    hardware.amdgpu.opencl.enable = true;

    environment.gnome.excludePackages = with pkgs; [
      gnome-photos
      geary
      gnome-tour
      cheese
      gnome-music
      gedit
      epiphany
      gnome-characters
      tali
      iagno
      hitori
      atomix
      yelp
      gnome-contacts
      gnome-initial-setup
    ];
    programs.dconf.enable = true;

    programs.niri.enable = true;

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Set your time zone.
    # console.useXkbConfig = true;

    # Enable automatic login for the user.
    # services.getty.autologinUser = "stefan";

    # services.interception-tools = {
    # enable = true;
    # plugins = [ pkgs.interception ]
    # udevmonConfig = ''
    #    - JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.caps2esc}/bin/caps2esc | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
    #      DEVICE:
    #        EVENTS:
    #          EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
    # '';
    # };
    services.fwupd.enable = true;
    # systemd.services.fprintd = {
    #   wantedBy = [ "multi-user.target" ];
    #   serviceConfig.Type = "simple";
    # };
    # services.fprintd.enable = true;
    # services.fprintd.tod.enable = true;
    # services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix;
    # boot.initrd.systemd.enable = true;
    environment.systemPackages = [ pkgs.tpm2-tss ];
    system.stateVersion = "25.05";
  };
}
