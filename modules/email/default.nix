{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.email;
in
{
  options.modules.email = {
    enable = lib.mkEnableOption "email";
  };

  config = lib.mkIf cfg.enable {
    accounts.email.accounts.personal = {
      address = "stefan@s00.xyz";
      primary = true;
      realName = "Stefan Weigl-Bosker";
      userName = "stefan";
      passwordCommand = "${pkgs.pass}/bin/pass show email/stefan@s00.xyz";
      aerc = {
        enable = true;
        extraAccounts = {
          default = "INBOX";
        };
      };
      imap = {
        host = "imap.s00.xyz";
      };
      smtp = {
        host = "smtp.s00.xyz";
        port = 465;
        tls.enable = true;
      };
      thunderbird.enable = true;
    };
  };
}
