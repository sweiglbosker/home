{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.mpd;
  scheme = config.modules.scheme;
in
{
  options.modules.mpd = {
    enable = lib.mkEnableOption "mpd";
  };

  config = lib.mkIf cfg.enable {
    services.mpd = {
      enable = true;
      extraConfig = ''
        audio_output {
          type "pipewire"
          name "My PipeWire Output"
        }
      '';
      musicDirectory = "~/music";
    };
    services.mpd-discord-rpc.enable = true;
    services.mpdscribble.enable = true;
  };
}
