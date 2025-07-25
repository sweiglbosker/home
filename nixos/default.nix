{ config, lib, pkgs, inputs, ... }:
let 
  cfg = config.nixos; 
in
{
  imports = [
    ./bluetooth.nix
    ./osu.nix
    ./keyd.nix
    ./yubikey.nix
  ];

  options.nixos = with lib.options; {
    hostname = mkOption { 
      type = lib.types.str;
      description = "Hostname for the system";
      default = "nixos";
    };

    # timezone = mkOption {
    #   type = lib.types.str;
    #   description = "Fallback timezone if location cannot be determined";
    #   default = "America/New_York";
    # };

    username = mkOption {
      type = lib.types.str;
      description = "Username for the main user";
      default = "stefan";
    };

    shell = mkOption {
      type = lib.types.package;
      default = pkgs.zsh;
      description = "Interactive shell for main user";
    };

    wifi = mkOption {
      type = lib.types.bool;
      description = "Whether to enable wireless networking via NetworkManager";
      default = true;
    };
  };

  config = {
    # nixos = {
    # };
    nix = {
      settings.experimental-features = [ "nix-command" "flakes" ];
    };

    # time.timeZone = lib.mkDefault cfg.timezone;
    services.automatic-timezoned.enable = true;

    nixpkgs.config.allowUnfree = true;

    boot = {
      consoleLogLevel=0;
      initrd.verbose = false;
      initrd.systemd.enable = true; # required for early stuff
      kernelPackages = pkgs.linuxPackages_latest;
      kernelParams = ["quiet" "splash"  "rd.systemd.show_status=false" "rd.udev.log_level=3" "udev.log_priority=3" "boot.shell_on_fail"];
      loader = {
        timeout = 0;
        systemd-boot = {
          enable = true;
          consoleMode = "auto";
          editor = false;
        };
        efi.canTouchEfiVariables = true;
      };
      plymouth = {
        enable = true;
      };
    };

    networking = {
      hostName = cfg.hostname;
      networkmanager.enable = cfg.wifi;
    };

    documentation.dev.enable = true;

    users.users."${cfg.username}" = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "input" # TODO: remove;
        "uinput"
        "networkmanager"
        "gamemode"
      ];
        # ++ (lib.optional cfg.wifi "networkmanager")
        # ++ (lib.optional cfg.gaming "gamemode");
      packages = with pkgs; [
        unzip
        tree
        ungoogled-chromium
      ];
      shell = cfg.shell;
    };

    environment.systemPackages = with pkgs; [
      neovim
      wl-clipboard
      wmenu
      gnupg
      pinentry-qt
      btop
      man-pages
      man-pages-posix
      cage
      zsh
      discord-ptb
    ] ++ (lib.optional cfg.wifi networkmanagerapplet); # TODO


    services.greetd = {
      enable = false;
      settings = {
        initial_session = {
          command = "sway --unsupported-gpu";
          user = "${cfg.username}";
        };
        default_session = {
          command = "${pkgs.greetd.greetd}/bin/agreety --cmd 'sway --unsupported-gpu'"; 
        };
      };
    };

    programs.zsh = {
      enable = true;
      # TODO
      shellInit = ''
        # autoload -Uz add-zsh-hook # avoids an error with system prompt
      '';
      # promptInit = "";
    };
    # TODO
    programs.foot.enable = true;
    programs.foot.enableZshIntegration = false; # TODO: https://github.com/NixOS/nixpkgs/pull/409627
    programs.sway.enable = true;
    programs.sway.package = pkgs.sway;

    programs.steam = {
      enable = true;
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
          users = ["${cfg.username}"];
          keepEnv = true;
          persist = true;
        }];
      };
    };

		i18n.defaultLocale = "en_US.UTF-8";

		i18n.extraLocaleSettings = {
			LC_ADDRESS = "en_US.UTF-8";
			LC_IDENTIFICATION = "en_US.UTF-8";
			LC_MEASUREMENT = "en_US.UTF-8";
			LC_MONETARY = "en_US.UTF-8";
			LC_NAME = "en_US.UTF-8";
			LC_NUMERIC = "en_US.UTF-8";
			LC_PAPER = "en_US.UTF-8";
			LC_TELEPHONE = "en_US.UTF-8";
			LC_TIME = "en_US.UTF-8";
		};
    
    services.xserver.xkb.layout = "us";
    services.xserver.xkb.variant = "colemak_dh,";

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      wireplumber.enable = true;
      pulse.enable = true;
    };

    services.libinput.enable = true;

    # environment.pathsToLink = [ "/share/zsh" ];
    console = {
      packages = [
        pkgs.cozette
      ];
      earlySetup = true;
      useXkbConfig = true;
      font = "${pkgs.cozette}/share/consolefonts/cozette12x26.psfu";
      colors = [
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
    };
    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        zlib
        zstd
        stdenv.cc.cc
        curl
        openssl
        attr
        libssh
        bzip2
        libxml2
        acl
        libsodium
        util-linux
        xz
        systemd
        pipewire
        libelf
        glib
        gtk2
        libusb1
        flac
        dbus
        cairo
        fontconfig
        freetype
        stdenv.cc.cc.lib
      ];
    };

    services.printing.enable = true;
    services.printing.drivers = [ pkgs.gutenprint pkgs.brlaser pkgs.brgenml1lpr pkgs.brgenml1cupswrapper ];
  };
}
