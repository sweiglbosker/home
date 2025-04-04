{ config, lib, pkgs, ... }:
let
  cfg = config.modules.lazygit;
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
            # activeBorderColor = [ "#8f8aac"  "bold" ];
            activeBorderColor = [ "#8f8aac"  "bold" ];
            inactiveBorderColor = [ "#4c4c4c" ];
            searchingActiveBorderColor = [ "#ceb188" ];
            optionsTextColor = [ "#8f8aac" ];
            selectedLineBgColor = [ "#262626" ];
            cherryPickedCommitBgColor = [ "#4c4c4c" ];
            cherryPickedCommitFgColor = [ "#8f8aac" ];
            markedBaseCommitFgColor = [ "#8f8aac" ];
            unstagedChangesColor = [ "#ac8a8c" ];
            defaultFgColor = [ "#cacaca" ];
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
