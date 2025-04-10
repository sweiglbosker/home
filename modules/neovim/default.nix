{ config, lib, pkgs, ...}:
let
  cfg = config.modules.neovim;
  scheme = config.modules.scheme;
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
      viAlias = false;
      vimAlias = false;
      vimdiffAlias = true;
      plugins = with pkgs.vimPlugins; [
        nvim-treesitter
        (nvim-treesitter.withPlugins (p: with p; [
          tree-sitter-nix
          tree-sitter-make
          tree-sitter-verilog
          tree-sitter-scheme
          tree-sitter-llvm
          tree-sitter-html
          tree-sitter-glsl
          tree-sitter-devicetree
          tree-sitter-cuda
          tree-sitter-c
          tree-sitter-cpp
          tree-sitter-lua
          tree-sitter-zig
          tree-sitter-rust
          tree-sitter-toml
          tree-sitter-markdown
          tree-sitter-markdown-inline
        ]))

        {
          plugin = lean-nvim;
          config = ''
            require('lean').setup{ mappings = true }
          '';
          type = "lua";
        }
        plenary-nvim
        nvim-lspconfig
        base16-nvim
        telescope-nvim
        telescope-fzf-native-nvim
        vim-obsession
      ];
      # extraLuaPackages = ps: with ps; [
      # ];
      extraLuaConfig = ''
        vim.cmd[[
        colorscheme ${scheme.name}
        hi PmenuSel guifg=${scheme.base05} guibg=${scheme.base03}
        hi StatusLine guibg=fg guifg=bg cterm=reverse gui=bold
        hi FloatBorder guifg=${scheme.base01}
        hi WinSeparator guifg=${scheme.base01}
        hi WinBar guifg=${scheme.base03}
        ]]

        ${builtins.readFile ./nvim/init.lua}
        vim.cmd[[${scheme.extraVimConfig}]]
      '';
    };
  };
}
