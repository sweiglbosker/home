{ config, lib, pkgs, ... }:
let
  cfg = config.modules.lazygit;
  scheme = config.modules.scheme;
in
{
  options.modules.lazygit = {
    enable = lib.mkEnableOption "lazygit";
  };

  config = lib.mkIf cfg.enable {
    programs.lazygit = {
      enable = true;
      settings = {
        keybinding = {
          universal = {
            "prevItem-alt" = "e";
            "nextItem-alt" = "n";
            "prevBlock-alt" = "m";
            "nextBlock-alt" = "i";
            "scollUpMain-alt1" = "E";
            "scollDownMain-alt1" = "N";
            nextMatch = "j";
            prevMatch = "J";
            new = "j";
            edit = "k";
            createRebaseOptionsMenu = "h";
          };
          files = {
            ignoreFile = "l";
          };
          branches = {
            viewGitFlowOptions = "l";
          };
          commits = {
            startInteractiveRebase = "u";
          };
        };
        gui= {
          notARepository = "skip";
          mouseEvents = false;
          showRandomTip = false;
          border = "single";
          theme = {
            activeBorderColor = [ scheme.base0D  "bold" ];
            inactiveBorderColor = [ scheme.base03 ];
            searchingActiveBorderColor = [ scheme.base09 ];
            optionsTextColor = [ scheme.base0D ];
            selectedLineBgColor = [ scheme.base02 ];
            cherryPickedCommitBgColor = [ scheme.base03 ];
            cherryPickedCommitFgColor = [ scheme.base0D ];
            markedBaseCommitFgColor = [ scheme.base0D ];
            unstagedChangesColor = [ scheme.base0F ];
            defaultFgColor = [ scheme.base05 ];
          };
          git = {
            paging.useConfig = true;
            parseEmoji = true;
          };
        };
      };
    };
  };
}
