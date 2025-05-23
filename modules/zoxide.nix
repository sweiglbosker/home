{ config, lib, pkgs, ... }:
let
  cfg = config.modules.zoxide;

  inherit (lib) mkEnableOption mkOption mkIf types;
in
{
  options.modules.zoxide = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "enable zoxide";
    };
  };

  config = mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
      # options = [
      # ];
    };
  };
}
