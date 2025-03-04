{ self, config, lib, pkgs, nixgl, ... }:
let
  cfg = config.modules.services;

  inherit (lib) mkOption types listOf;
  runFile = name: value: {
    ${"service/" + name + "/run"} = {
      text = value.run;
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
    services = mkOption {
      description = "List of user services to run on login";
      type = types.attrsOf (types.submodule {
        options = {
          run = mkOption {
            type = types.str;
            description = "The 'run' script for the service";
            example = ''
              #!/bin/sh

              exec chpst -e "$TURNSTILE_ENV_DIR" foo
            '';
          };
        };
      });
    };
  };

  config = lib.mkIf cfg.enable { 
    xdg.configFile = (lib.concatMapAttrs runFile cfg.services);
  };
}
