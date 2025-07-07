{ config, lib, pkgs, ... }:
let
  cfg = config.modules.gpg;

  inherit (lib) mkEnableOption mkOption mkIf types;
in
{
  options.modules.gpg = {
    enable = mkEnableOption "gpg";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      pinentry-qt
    ];

    programs.gpg = {
      scdaemonSettings = {
        disable-ccid = true; 
      };
      settings = {
        no-comments = true;
        fixed-list-mode = true;
        no-emit-version = true;
        keyd-format = "0xlong";
        list-options = "show-uid-validity";
        verify-options = "show-uid-validity";
        with-fingerprint = true;
        require-cross-certification = true;
        no-symkey-cache = true;
        use-agent = true;
        throw-keyds = true;

        personal-cipher-preferences = "AES256 AES192 AES";
        personal-digest-preferences = "SHA512 SHA384 SHA256";
        personal-compress-preferences = "ZLIB BZIP2 ZIP Uncompressed";
        default-preference-list = "SHA512 SHA384 SHA256 AES256 AES192 AES ZLIB BZIP2 ZIP Uncompressed";
        cert-digest-algo = "SHA512";
        s2k-digest-algo = "SHA512";
        s2k-cipher-algo = "AES256";
        charset = "utf-8";
      };
    };
    services.gpg-agent = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      defaultCacheTtl = 60;
      maxCacheTtl = 120;
      enableSshSupport = true;
      noAllowExternalCache = true;
      pinentryPackage = pkgs.pinentry-qt;

      sshKeys = [ "36663E191B00E51513F90FA5CF2BCE8461C297CD" "97D70F96084527401BBA8AB714165B7413D13345" ];
    };
  };
}
