{ config, lib, pkgs, inputs, ...}:
let
  cfg = config.modules.global;
in
{
  imports = [ ./default.nix ];

  options.modules.global = with lib.options; {
    notNixOS = mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether nix is running outside of NixOS.";
    };
    wayland = mkEnableOption "Wayland";
    extraPackages = mkOption {
      type = with lib.types; listOf package;
      description = "List of extra packages to install";
      example = [ pkgs.cowsay pkgs.lolcat ];
      default = [];
    };
  };

  config = {
    modules = rec {
      global = {
        wayland = lib.mkDefault true;
      };
      sway = {
        wrapWithNixGL = cfg.notNixOS;
      };
    };

    nixGL = lib.mkIf cfg.notNixOS {
        packages = inputs.nixgl.packages;
        defaultWrapper = "mesa";
    };

    programs = {
      home-manager.enable = true;
    };

    targets.genericLinux.enable = cfg.notNixOS;

    home = {
      username = "stefan";
      homeDirectory = "/home/stefan";
      stateVersion = "24.11";

      packages = with pkgs; [
        nerd-fonts.comic-shanns-mono
      ] ++ (lib.optional cfg.notNixOS nixgl.auto.nixGLDefault)
        ++ (lib.optionals cfg.wayland 
        [
          wl-clipboard
          #...
        ]);
    };

  };
}
