{ config, lib, pkgs, ... }:
let
  cfg = config.modules.colors.mountain;
  hexColorRegex = ''#([0-9a-fA-F]{3}){1,2}'';
  hexColor = {
    type = lib.types.strMatching hexColorRegex;
  };
in
{
  options.modules.colors.mountain = {
    enable = lib.mkEnableOption "mountain theme";
  };

  config = lib.mkIf cfg.enable {
    modules.scheme = {
      name = "base16-mountain";
      base00 = "#0f0f0f";
      base01 = "#191919";
      base02 = "#262626";
      base03 = "#4c4c4c";
      base04 = "#ac8a8c";
      base05 = "#cacaca";
      base06 = "#e7e7e7";
      base07 = "#f0f0f0";
      base08 = "#ac8a8c";
      base09 = "#ceb188";
      base0A = "#aca98a";
      base0B = "#8aac8b";
      base0C = "#8aabac";
      base0D = "#8f8aac";
      base0E = "#ac8aac";
      base0F = "#ac8a8c";
      # extraVimConfig = 
      # ''
      #   hi LineNr guifg=#ceb188
      #   hi LineNrAbove guifg=#262626
      #   hi LineNrBelow guifg=#262626
      #   hi CursorLineNr guifg=#ceb188 guibg=#191919 gui=bold
      #   hi FloatBorder guifg=#4c4c4c
      #   hi Pmenu guibg=#0d0d0d
      #   hi BlinkCmpMenuBorder guifg=#4c4c4c 
      #   hi BlinkCmpDocBorder guifg=#4c4c4c 
      #   hi PmenuSel guibg=#191919 guifg=#cacaca
      #   hi WinBar guifg=#4c4c4c
      #   hi WinSeparator guifg=#191919
      #   "
      #   "" status line
      #   hi StatusLine guibg=#191919 guifg=#4c4c4c
      #   hi StatuslineInactive guibg=#191919 guifg=#4c4c4c gui=NONE
      #   hi StatuslineAccent guifg=#0f0f0f guibg=#aca98a gui=bold
      #   hi StatuslineInsertAccent guifg=#0f0f0f guibg=#8aabac gui=bold
      #   hi StatuslineVisualAccent guifg=#0f0f0f guibg=#8f8aac gui=bold
      #   hi StatuslineReplaceAccent guifg=#0f0f0f guibg=#ac8a8c gui=bold
      #   hi StatuslineTerminalAccent guifg=#0f0f0f guibg=#ac8a8c gui=bold
      #   hi StatuslineCommandAccent guifg=#0f0f0f guibg=#8aac8b gui=bold
      #   hi StatuslineFileIcon guibg=#191919 guifg=#8f8aac
      #   hi StatuslineInfo guibg=#191919 guifg=#4c4c4c 
      #   hi LspError guibg=#191919 guifg=#c49ea0
      #   hi LspWarn guibg=#191919 guifg=#8f8aac
      #   hi LspInfo guibg=#191919 guifg=#8f8aac
      #   hi LspHint guibg=#191919 guifg=#8aabac
      # '';
    };
  };
}
