{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.weechat;

  weechat' = pkgs.weechat.override {
    configure = { availablePlugins, ... }: {
      scripts = with pkgs.weechatScripts; [
        edit
        colorize_nicks
        autosort
        highmon
        weechat-grep
        weechat-go
        weechat-notify-send
      ];
    };
  };
in
{
  options.modules.weechat = {
    enable = lib.mkEnableOption "weechat";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      weechat'
    ];
  };
}
