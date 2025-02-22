{ config, libs, pkgs, ... }:
{
  targets.genericLinux.enable = true;

  home = {
    username = "stefan";
    homeDirectory = "/home/stefan";
    stateVersion = "24.11";
  };

  nixGL.packages = import <nixgl> { inherit pkgs; };
  nixGL.defaultWrapper = "mesa";

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    wl-clipboard
    mako
    wmenu
    i3status
    nerd-fonts.comic-shanns-mono
    (writeShellScriptBin "browser" ''
      swaymsg 'set $PROP newcont:tabbed ; exec qutebrowser --target window'
    '')
    (writeShellScriptBin "exit-sway" ''
        pkill pipewire
        swaymsg exit
    '')
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    XDG_CACHE_HOME="$(mktemp -d)";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.neovim = 
  let
    lua = str: "lua << EOF\n${str}\nEOF\n"; 
    luaImport = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in
  {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
        {
          plugin = nvim-lspconfig;
          config = let
            servers = [
              { name = "clangd"; }
            ];
          in lua (pkgs.lib.strings.concatStrings (pkgs.lib.lists.forEach servers (s: "require('lspconfig')['${s.name}'].setup(${s.config or "{}"})\n")));
        }

        (nvim-treesitter.withPlugins (p: with p; [
                tree-sitter-nix
                tree-sitter-c
                tree-sitter-lua
                tree-sitter-zig
                tree-sitter-markdown
                tree-sitter-markdown-inline
        ]))

        base16-nvim
        telescope-nvim
        telescope-fzf-native-nvim
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./nvim/settings.lua}
      ${builtins.readFile ./nvim/keybinds.lua}
    '';
  };

  programs.qutebrowser = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.qutebrowser;
    loadAutoconfig = true;
  };

  programs.git = {
    enable = true;
    userName = "Stefan Weigl-Bosker";
    userEmail = "stefan@s00.xyz";
  };

  wayland.windowManager.sway = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.sway;

    config = rec {
      modifier = "Mod1";

      left = "m";
      down = "n";
      up = "e";
      right = "i";

      fonts = {
        names = [ "ComicShannsMono Nerd Font Mono" ]; # material
        size = 11.0;
      };

      terminal = "foot";
      menu = "wmenu-run -n 4c4c4c -N 0d0d0d -s 8aac8b -S 0d0d0d -l 10";
  
      defaultWorkspace = "workspace number 1";

      input = {
        "type:keyboard" = {
          xkb_layout = "us";
          xkb_variant = "colemak_dh";
        };
        "type:touchpad" = {
          dwt = "enabled"; # turn off if u are a gamer
          tap = "enabled";
          middle_emulation = "enabled";
        };
      };

      output = {
        "*" = {
          bg = "#0d0d0d solid_color";
        };
        "eDP-1" = {
          mode = "2880x1920@120.00Hz";
          scale = "2.0";
        };
      };

      colors = {
        background = "#0f0f0f";
        focused = {
          border = "#191919" ;
          background = "#191919";
          text = "#ac8aac";
          indicator = "#282a2e";
          childBorder = "#8aac8b";
        };
        focusedInactive = {
          border = "#191919";
          background = "#191919";
          text = "#ac8aac";
          indicator = "#282a2e";
          childBorder = "#191919";
        };
        unfocused = {
          border = "#191919";
          background = "#191919";
          text = "#4c4c4c";
          indicator = "#0f0f0f";
          childBorder = "#191919";
        };
      };

      bars = [{
        statusCommand = "i3status";
        mode = "hide";
        hiddenState = "hide";
        fonts = {
          names = [ "ComicShannsMono Nerd Font Mono" ];
          size = "10.0";
        };
        extraConfig = ''
          modifier ${modifier}
        '';
        colors = {
          background = "#0d0d0d";
          statusline = "#cacaca";
          focusedWorkspace = {
            border = "#0d0d0d";
            background = "#0d0d0d";
            text = "#ac8aac";
          };
          activeWorkspace = {
            border = "#0d0d0d";
            background = "#0d0d0d";
            text = "#4c4c4c";
          };
          inactiveWorkspace = {
            border = "#0d0d0d";
            background = "#0d0d0d";
            text = "#4c4c4c";
          };
          bindingMode = {
            border = "#0d0d0d";
            background = "#0d0d0d";
            text = "#ac8aac";
          };
        };
      }];

      focus = {
        followMouse = false;
        wrapping = "force";
      };

      window = {
        border = 1;
        hideEdgeBorders = "--i3 smart";
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
        "${modifier}+Shift+w" = "exec browser";
        "${modifier}+d" = "exec ${menu}";

        "${modifier}+Shift+c" = "kill";

        "${modifier}+Shift+r" = "reload";
        "${modifier}+Shift+q" = "exec swaynag -t warning -m 'do you really want to exit?' -B 'yes, exit' 'exit-sway'";

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
        "${modifier}+0" = "workspace number 0";

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
        "--locked XF86AudioRaiseVolume" = "exec volumectl -d -u up";
        "--locked XF86AudioLowerVolume" = "exec volumectl -d -u down";
        "--locked XF86AudioMute" = "exec volumectl -d toggle-mute";
        "--locked XF86AudioMicMute" = "exec volumectl -d -m toggle-mute";
        "--locked XF86MonBrightnessDown" = "exec lightctl -d down";
        "--locked XF86MonBrightnessUp" = "exec lightctl -d up";
      };

      startup = [
        { command = "foot -s"; }
        { command = "wayneko --layer bottom --follow-pointer true --background-colour 0xcacaca --outline-colour 0x0f0f0f"; }
        { command = "pipewire"; always = true; } # TODO need to fix this instead of running a new session every time
        { command = "mpd"; }
        { command = "mpdscribble"; }
        { command = "avizo-service"; } # disable if on nixos or systemd
      ];

      seat = {
        "*" = {
          hide_cursor = "1500";
          xcursor_theme = "Adwaita 18";
        };
      };
    };

    extraConfigEarly = ''
      set $PROP none
    '';

    extraConfig = ''
      title_align center
      default_border pixel 1
    '';
  };

  programs.foot = {
    enable = true;
    server = {
      enable = true;
    };
    settings = {
      main = {
        font="ComicShannsMono Nerd Font Mono:size=12";
        title="term";
        resize-by-cells="no";
        pad="0x0 center";
      };

      desktop-notifications.command = "notify-send -a \${app-id} -i \${app-id} \${title} \${body}";
      url.label-letters="arstneio";

      cursor = {
        style="block";
        blink="no";
        color="0f0f0f cacaca";
      };

      colors = {
        foreground="cacaca";
        background="0f0f0f";
        regular0="0f0f0f";
        regular1="ac8a8c";
        regular2="8aac8b";
        regular3="aca98a";
        regular4="8f8aac";
        regular5="ac8aac";
        regular6="8aabac";
        regular7="cacaca";
        bright0="262626 ";
        bright1="c49ea0 ";
        bright2="9ec49f ";
        bright3="c4c19e ";
        bright4="a39ec4 ";
        bright5="c49ec4 ";
        bright6="9ec3c4 ";
        bright7="f5f5f5 ";
        "16"="ceb188";
        "17"="ac8a8c";
        "18"="191919";
        "19"="262626";
        "20"="ac8a8c";
        "21"="e7e7e7";
      };
    };
  };

  services.avizo = {
        enable = true;
  };
}
