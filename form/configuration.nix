{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "max";
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "form"; 

  networking.networkmanager.enable = true;  

  time.timeZone = "America/New_York";

  console = {
    useXkbConfig = true; # use xkb.options in tty.
  };

  services.xserver.xkb.layout = "us";
  services.xserver.xkb.variant = "colemak_dh";

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    wireplumber.enable = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;

  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
    };
  };

  users.users.stefan = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
      discord-ptb
      ungoogled-chromium
    ];
    shell = pkgs.zsh;
  };

  #programs.firefox.enable = true;
  programs.foot.enable = true;
  programs.sway.enable = true;

  security = {
    polkit.enable = true;
    rtkit.enable = true;
    doas = {
      enable = true;
      extraRules = [{
        users = ["stefan"];
  #      keepEnv = true;
        persist = true;
      }];
    };
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd 'sway --unsupported-gpu'";
        user = "greeter";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    zsh
    neovim
    wl-clipboard
    wmenu
    gnupg
    pinentry-qt
    btop
  ];

  environment.pathsToLink = [ "/share/zsh" ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;


  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];	
  };

  system.stateVersion = "24.11";
}

