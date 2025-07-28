{
  self,
  config,
  lib,
  pkgs,
  nixgl,
  ...
}:
let
  cfg = config.modules.sway;
  scheme = config.modules.scheme;
in
{
  options.modules.sway = {
    enable = lib.mkEnableOption "sway";
    wrapWithNixGL = lib.mkEnableOption "NixGL wrapper.";
    terminal = lib.mkOption {
      type = lib.types.str;
      description = "Terminal command.";
    };
    startup = lib.mkOption {
      type = lib.types.listOf (
        lib.types.submodule {
          options = {
            command = lib.mkOption {
              type = lib.types.string;
              description = "Command to be executed on startup.";
            };
            always = lib.mkOption {
              type = lib.types.bool;
              default = false;
              description = "Whether to run command on each restart";
            };
          };
        }
      );
      default = [ ];
      description = "List of commands that sway will run on startup. This should be used only for sway specific applications";
    };
  };

  config = {
    home.packages = with pkgs; [
      (writeShellScriptBin "browser" ''
        swaymsg 'set $PROP newcont:tabbed ; exec qutebrowser --target window'
      '')
      autotiling
      pamixer
      killall
    ];
    wayland.windowManager.sway = lib.mkIf cfg.enable {
      checkConfig = false;
      enable = true;
      systemd.enable = true;
      package = if cfg.wrapWithNixGL then (config.lib.nixGL.wrap pkgs.sway) else pkgs.sway;
      #      package = null;
      config = rec {
        modifier = "Mod4";

        left = "m";
        down = "n";
        up = "e";
        right = "i";

        fonts = {
          names = [
            "sans-serif"
            "monospace"
          ];
          # style = "Bold";
          size = 10.0;
        };

        terminal = "${cfg.terminal}";
        #   menu = ''wmenu-run -n 4c4c4c -N 0d0d0d -s 8aac8b -S 0d0d0d -l 10 -f "ComicShannsMono Nerd Font Mono 10"'';
        # menu = "tofi-run | xargs swaymsg exec";
        menu = "fuzzel";

        defaultWorkspace = "workspace number 1";

        input = {
          "type:keyboard" = {
            xkb_layout = "us,us";
            xkb_variant = "colemak_dh,";
          };
          "type:touchpad" = {
            dwt = "enabled"; # turn off if u are a gamer
            tap = "enabled";
            middle_emulation = "enabled";
          };
          "type:pointer" = {
            accel_profile = "flat";
          };
        };

        output = {
          "*" = {
            bg = "${scheme.base00} solid_color";
          };
          "eDP-1" = {
            mode = "2880x1920@120.00Hz";
            scale = "2.0";
          };
          "DP-2" = {
            mode = "1920x1080@239.761Hz";
            position = "0,440";
          };
          "HDMI-A-1" = {
            transform = "90";
            position = "1920,0";
          };
        };

        # gaps = {
        #   inner = 10;
        #   outer = 0;
        # };

        workspaceAutoBackAndForth = false;
        workspaceOutputAssign = [
          {
            output = "HDMI-A-1";
            workspace = "0";
          }
        ];

        colors = {
          background = scheme.base00;
          focused = {
            border = scheme.base0D; # the border around the titlebar
            background = scheme.base0D;
            childBorder = scheme.base0D;
            text = scheme.base00; # TODO: light/dark
            indicator = scheme.base09;
          };
          focusedInactive = {
            border = scheme.base00;
            background = scheme.base00;
            text = scheme.base0D;
            indicator = scheme.base02;
            childBorder = scheme.base00;
          };
          unfocused = {
            border = scheme.base00;
            background = scheme.base00;
            text = scheme.base04;
            indicator = scheme.base01;
            childBorder = scheme.base00;
          };
        };

        bars = [
          # {
          #   command = "waybar";
          # }
          {
            statusCommand = "py3status --wm sway";
            # mode = "hide";
            # hiddenState = "hide";
            position = "top";
            fonts = {
              names = [
#                "sans-serif"
                "monospace"
              ];
              size = "10.0";
            };
            extraConfig = ''
              modifier ${modifier}
              separator_symbol " "
            '';
            colors = {
              background = scheme.base10; # "#0d0d0d";
              statusline = scheme.base05;
              focusedWorkspace = {
                border = scheme.base10; # "#0d0d0d";
                background = scheme.base10; # "#0d0d0d";
                text = scheme.base05;
              };
              activeWorkspace = {
                border = scheme.base10; # "#0d0d0d";
                background = scheme.base10; # "#0d0d0d";
                text = scheme.base01;
              };
              inactiveWorkspace = {
                border = scheme.base10; # "#0d0d0d";
                background = scheme.base10; # "#0d0d0d";
                text = scheme.base01;
              };
              bindingMode = {
                border = scheme.base00; # "#0d0d0d";
                background = scheme.base10; # "#0d0d0d";
                text = scheme.base0E;
              };
            };
          }
        ];

        focus = {
          followMouse = false;
          wrapping = "force";
        };

        window = {
          border = 2;
          # hideEdgeBorders = "--i3 smart";
          commands = [
            {
              command = "mark --add \"prop:$$PROP:\"";
              criteria = {
                shell = ".";
              };
            }
            {
              command = "splith";
              criteria = {
                con_mark = "^prop.*:newcont:";
              };
            }
            {
              command = "layout tabbed";
              criteria = {
                con_mark = "^prop.*:tabbed:";
              };
            }
            {
              command = "mark --toggle \"prop:$$PROP:\" ; set $$PROP none";
              criteria = {
                con_mark = "^prop:";
              };
            }
          ];
        };

        keybindings = {
          "${modifier}+Return" = "exec ${terminal}";
          "${modifier}+p" = "exec passmenu";
          "${modifier}+Shift+w" = "exec browser";
          "${modifier}+d" = "exec ${menu}";

          "${modifier}+Shift+c" = "kill";

          "${modifier}+Shift+r" = "reload";
          "${modifier}+Shift+q" =
            "exec swaynag -t warning -m 'do you really want to exit?' -B 'yes, exit' 'swaymsg exit'";

          "${modifier}+${left}" = "focus left";
          "${modifier}+${down}" = "focus down";
          "${modifier}+${up}" = "focus up";
          "${modifier}+${right}" = "focus right";

          "${modifier}+a" = "focus parent";
          "${modifier}+s" = "focus child";

          "${modifier}+Shift+${left}" = "move left";
          "${modifier}+Shift+${down}" = "move down";
          "${modifier}+Shift+${up}" = "move up";
          "${modifier}+Shift+${right}" = "move right";

          "${modifier}+r" = "mode resize";

          "${modifier}+1" = "workspace number 1";
          "${modifier}+2" = "workspace number 2";
          "${modifier}+3" = "workspace number 3";
          "${modifier}+4" = "workspace number 4";
          "${modifier}+5" = "workspace number 5";
          "${modifier}+6" = "workspace number 6";
          "${modifier}+7" = "workspace number 7";
          "${modifier}+8" = "workspace number 8";
          "${modifier}+9" = "workspace number 9";
          "${modifier}+period" = "workspace number 0";

          "${modifier}+Shift+1" = "move container to workspace number 1";
          "${modifier}+Shift+2" = "move container to workspace number 2";
          "${modifier}+Shift+3" = "move container to workspace number 3";
          "${modifier}+Shift+4" = "move container to workspace number 4";
          "${modifier}+Shift+5" = "move container to workspace number 5";
          "${modifier}+Shift+6" = "move container to workspace number 6";
          "${modifier}+Shift+7" = "move container to workspace number 7";
          "${modifier}+Shift+8" = "move container to workspace number 8";
          "${modifier}+Shift+9" = "move container to workspace number 9";
          "${modifier}+Shift+0" = "move container to workspace number 0";

          "${modifier}+Shift+minus" = "move scratchpad";
          "${modifier}+minus" = "scratchpad show";

          "${modifier}+h" = "splith";
          "${modifier}+v" = "splitv";

          "${modifier}+Shift+s" = "layout stacking";
          "${modifier}+w" = "layout tabbed";
          "${modifier}+t" = "layout toggle split";
          "${modifier}+Shift+space" = "floating toggle";
          "${modifier}+space" = "focus mode_toggle";

          "${modifier}+Shift+f" = "fullscreen";
          # this can probably be simplified but im not a sed wizard
          "--locked XF86AudioRaiseVolume" = "exec pamixer -ui 2 && pamixer --get-volume > $WOBSOCK && killall -s USR1 -r py3status";
          "--locked XF86AudioLowerVolume" = "exec pamixer -ud 2 && pamixer --get-volume > $WOBSOCK && killall -s USR1 -r py3status";
          "--locked XF86AudioMute" =
            ''exec pamixer --toggle-mute && ( [ "$(pamixer --get-mute)" = "true" ] && echo 0 > $WOBSOCK ) || pamixer --get-volume > $WOBSOCK && killall -s USR1 -r py3status'';
          "--locked XF86MonBrightnessUp" = "exec light -A 5 && light -G | cut -d'.' -f1 > $WOBSOCK";
          "--locked XF86MonBrightnessDown" = "exec light -U 5 && light -G | cut -d'.' -f1 > $WOBSOCK";
        };

        startup = cfg.startup;

        seat = {
          "*" = {
            # hide_cursor = "1500";
            xcursor_theme = "Adwaita 18";
          };
        };
      };

      extraConfigEarly = ''
        set $PROP none
        set $WOBSOCK $XDG_RUNTIME_DIR/wob.sock
      '';

      extraConfig = ''
        title_align center
        default_border pixel 1
        mouse_warping none
        output HDMI-A-1 disable
      '';
      # + ''
      #   blur enable
      #   blur_xray disable
      #   corner_radius 0
      #   shadows disable
      #   titlebar_separator disable
      #
      #   layer_effects "launcher" {
      #     reset;
      #     blur enable;
      #     shadows disable;
      #   }
      # '';
    };
  };
}
