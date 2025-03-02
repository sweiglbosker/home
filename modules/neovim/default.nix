{ config, lib, pkgs, ...}:
let
  cfg = config.modules.neovim;
in
{
  options.modules.neovim = {
    enable = lib.mkEnableOption "neovim";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."nvim/lua" = {
      source = ./nvim/lua;
      recursive = true;
    };

    xdg.configFile."nvim/after" = {
      source = ./nvim/after;
      recursive = true;
    };

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      plugins = with pkgs.vimPlugins; [
        (nvim-treesitter.withPlugins (p: with p; [
          tree-sitter-nix
          tree-sitter-c
          tree-sitter-cpp
          tree-sitter-lua
          tree-sitter-zig
          tree-sitter-markdown
          tree-sitter-markdown-inline
        ]))

        blink-cmp
        nvim-lspconfig
        base16-nvim
        telescope-nvim
        telescope-fzf-native-nvim
      ];
      extraLuaConfig = ''
        ${builtins.readFile ./nvim/init.lua}
      '';
    };
  };
}
