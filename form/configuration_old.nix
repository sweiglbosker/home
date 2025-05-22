{ config, lib, pkgs, inputs, kmonad, ... }:
let
  ttyColor = str: (lib.strings.removePrefix "#" str);
  scheme = config.modules.scheme;
in
{
  imports =
    [ 
      ../nixos
      ./hardware-configuration.nix
    ];

  services.kmonad = {
    enable = true;
    # keyboards = {
    # };
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "max";
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "form"; 

  networking.networkmanager.enable = true;  

  time.timeZone = "America/New_York";

  services.xserver.xkb.layout = "us";
  services.xserver.xkb.variant = "colemak_dh,";
  # services.xserver.enable = true;
  # services.displayManager.sddm.enable = true;
  # services.desktopManager.plasma6.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    wireplumber.enable = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;

  programs.zsh = {
    enable = true;
    ohMyZsh.enable = true;
  };

  documentation.dev.enable = true;

  users.users.stefan = {
    isNormalUser = true;
    extraGroups = [ 
      "wheel"
      "networkmanager" 
      "gamemode"
      "input" # TODO: can remove these later
      "uinput" 
    ]; 
    packages = with pkgs; [
      unzip
      tree
      discord-ptb
      ungoogled-chromium
      osu-lazer-bin
      xfce.thunar
    ];
    shell = pkgs.zsh;
  };

  #programs.firefox.enable = true;
  programs.foot.enable = true;
  programs.sway.enable = true;
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

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
    man-pages
    man-pages-posix
    wineWowPackages.staging
    winetricks
    wineWowPackages.waylandFull
    tamzen
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

  console.font = "${pkgs.tamzen}/share/consolefonts/TamzenForPowerline7x14.psf";
  console.useXkbConfig = true; 
  console.earlySetup = true;

  # services.kmscon = {
  #   enable = true;
  #   useXkbConfig = true;
  #   # hwRender = true; # broken 
  #   fonts = [ 
  #     { name = "Hack Nerd Font Mono"; package = pkgs.nerd-fonts.hack; }
  #   ];
  #   extraConfig = ''
  #     font-size=11
  #     palette-background=15, 15, 15
  #     palette-foreground=202, 202, 202
  #     palette-red=172, 138, 140
  #     palette-green=138, 172, 139
  #     palette-yellow=172, 169, 138
  #     palette-blue=143, 138, 172
  #     palette-magenta=172, 138, 172
  #     palette-cyan=138, 171, 172
  #     palette-white=240, 240, 240
  #     palette-light-grey=202, 202, 202
  #     palette-dark-grey=76, 76, 76
  #     palette-black=15, 15, 15
  #   '';
  # };

  # TODO
  # console.colors = [
  #    "${ttyColor scheme.base08}"
  #    "${ttyColor scheme.base0B}"
  #    "${ttyColor scheme.base0A}"
  #    "${ttyColor scheme.base0D}"
  #    "${ttyColor scheme.base0E}"
  #    "${ttyColor scheme.base0C}"
  #    "${ttyColor scheme.base05}"
  #    "${ttyColor scheme.base03}"
  #    "${ttyColor scheme.base08}"
  #    "${ttyColor scheme.base0B}"
  #    "${ttyColor scheme.base0A}"
  #    "${ttyColor scheme.base0D}"
  #    "${ttyColor scheme.base0E}"
  #    "${ttyColor scheme.base0C}"
  #    "${ttyColor scheme.base07}"
  # ];
  console.colors = [
    "0f0f0f"
		"ac8a8c"
		"8aac8b"
		"aca98a"
		"8f8aac"
		"ac8aac"
		"8aabac"
		"cacaca"
		"4c4c4c"
		"ac8a8c"
		"8aac8b"
		"aca98a"
		"8f8aac"
		"ac8aac"
		"8aabac"
		"f0f0f0"
  ];


  hardware.graphics.enable = true;
  boot.initrd.kernelModules = [ "nvidia" "nvidia_uvm" "nvidia_drm" ]; # otherwise it is loaded late and clears vram,
                                            # which resets console font
  # boot.initrd.kernelModules = [ "nvidia" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
  boot.kernelParams = [ 
    "quiet"
    "splash"
  ];
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

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];	
  };

  system.stateVersion = "24.11";
}

