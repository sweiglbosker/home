{ self, config, lib, pkgs, nixgl, ... }:
let
  cfg = config.modules.services;

  inherit (lib) mkOption types listOf;
  mkService = name: value: {
    ${"service/" + name + "/run"} = {
      text = value.run;
      executable = true;
    };
    ${"service/" + name + "/log/run"} = {
      enable = value.log != "";
      text = value.log;
      executable = true;
    };
  };
in
{
  options.modules.services = {
    name = mkOption {
      type = types.string;
    };
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to enable the user service manager module.";
    };
    coreServices = mkOption {
      type = types.listOf types.str; 
      description = "List of services to start first";
      example = [ "dbus" ];
      default = [];
    };
    services = mkOption {
      description = "List of user services to run on login";
      type = types.attrsOf (types.submodule {
        options = {
          run = mkOption {
            type = types.str;
            description = "The 'run' script for the service";
            example = 
            ''#!/bin/sh

              exec chpst -e "$TURNSTILE_ENV_DIR" foo
            '';
          };
          log = mkOption {
            type = types.nullOr types.str;
            description = "The log/run script for the service. A pipe is opened from the output of the 'run' process to this script";
            example = 
            ''#!/bin/sh

              exec vlogger -t dbus-$(id -u) -p daemon
            '';
            default = "";
          };
        };
      });
    };
  };

  config = lib.mkIf cfg.enable { 
    xdg.configFile = (lib.concatMapAttrs mkService cfg.services) 
      // { 
        "service/turnstile-ready/conf" = {
          text = ''core_services="${lib.strings.concatStringsSep " " cfg.coreServices}''; 
        };
      };
  };
}
