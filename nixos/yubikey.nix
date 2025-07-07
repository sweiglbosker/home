{ config, lib, pkgs, ... }:
let
  cfg = config.nixos.yubikey;
  inherit (lib) types mkOption;
in
{
  options.nixos.yubikey = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "enable yubikey support";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = builtins.attrValues {
      inherit (pkgs)
      yubioath-flutter
      yubikey-manager
      pam_u2f
      ;
    };

    # for gpg and ssh
    services.pcscd.enable = true; # https://ludovicrousseau.blogspot.com/2019/06/gnupg-and-pcsc-conflicts.html
    services.udev.packages = [ pkgs.yubikey-personalization ];

    security.pam = {
      u2f = {
        enable = true;
        origin = "pam://yubi";
        settings = {
          # interactive = true;
          interactive = false;
          cue = true;
          authfile = pkgs.writeText "u2f-mappings" (lib.concatStrings [
            config.nixos.username
            ":GB+R91Ur898D/fEgih7f/tsSDOaDw1QcEOSGzHs4fOUo5uCaliIiEK4fFGDClybL/8Qa7tGAN+mo0tU7PVmzfA==,GUPJuYykJoqBw7atGbIK/QcIATgJ3VZQKd1BrjMZ9g/f3nSejOv69LM5UCEoXAwuZHyJitVr1qYd1jLP2uckoQ==,es256,+presence"
          ]);
        };
      };
      services = {
        login.u2fAuth = true;
        sudo.u2fAuth = true;
      };
    };
  };
}
