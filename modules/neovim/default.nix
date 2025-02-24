{ config, lib, pkgs, ...}:
let
  cfg = config.modules.neovim;
  lua = str: "lua << EOF\n${str}\nEOF\n";
  luaImport = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
in
{
  options.modules.neovim = {
        enable = lib.mkEnableOption "neovim";
  };

  config = {
    programs.neovim = lib.mkIf cfg.enable {
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

        {
          plugin = neorg;
          config = lua ''
            require("neorg").setup()
          '';
        }
        base16-nvim
        telescope-nvim
        telescope-fzf-native-nvim
      ];
      extraLuaConfig = ''
          ${builtins.readFile ./settings.lua}
          ${builtins.readFile ./keybinds.lua}
          require("neorg").setup()
      '';
    };
  };
}
