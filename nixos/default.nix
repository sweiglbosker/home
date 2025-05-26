{ config, lib, pkgs, inputs, ... }:
let 
  cfg = config.nixos; 
in
{
  imports = [
    ./bluetooth.nix
    ./osu.nix
    # ./kmonad.nix
  ];

  options.nixos = with lib.options; {
    hostname = mkOption { 
      type = lib.types.str;
      description = "Hostname for the system";
      default = "nixos";
    };

    timezone = mkOption {
      type = lib.types.str;
      description = "Local timezone";
      default = "America/New_York";
    };

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

    time.timeZone = cfg.timezone;
    nixpkgs.config.allowUnfree = true;

    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.consoleMode = "max";
    boot.loader.efi.canTouchEfiVariables = true;

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
    ]; # TODO


    services.greetd = {
      enable = true;
      settings = {
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
      earlySetup = true;
      useXkbConfig = true;
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
    system.stateVersion = "24.11";
  };
}
