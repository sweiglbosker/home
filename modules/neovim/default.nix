{ config, lib, pkgs, ...}:
let
  cfg = config.modules.neovim;
  scheme = config.modules.scheme;
  tsparsers = pkgs.symlinkJoin {
    # if we don't symlink, startuptime grows by an order of magnitude because of long runtimepath
    name = "tsparsers";
    # paths = (pkgs.vimPlugins.nvim-treesitter.withAllGrammars).dependencies;
    paths = (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: with p; [
      tree-sitter-nix
      tree-sitter-nu
      tree-sitter-go
      tree-sitter-rst
      tree-sitter-lua
      tree-sitter-css
      tree-sitter-yaml
      tree-sitter-toml
      tree-sitter-scss
      tree-sitter-json
      tree-sitter-html
      tree-sitter-fish
      tree-sitter-bash
      tree-sitter-query
      tree-sitter-ocaml
      tree-sitter-ocaml-interface
      tree-sitter-latex
      tree-sitter-python
      tree-sitter-bibtex
      tree-sitter-verilog
      tree-sitter-comment
      tree-sitter-dockerfile
      tree-sitter-make
      tree-sitter-cmake
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
      tree-sitter-haskell
      tree-sitter-toml
      tree-sitter-markdown
      tree-sitter-markdown-inline
      tree-sitter-tablegen
    ])).dependencies;
  };
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

    # home.sessionVariables.MANPAGER = "nvim +Man!";

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = false;
      vimAlias = false;
      vimdiffAlias = true;
      plugins = with pkgs.vimPlugins; [
        # lazy loading
        lz-n

        # preconfigured treesitter parsers
        nvim-treesitter
        tsparsers

        # colorschemes. TODO: delete
        base16-nvim

        {
          plugin = nvim-highlight-colors;
          type = "lua";
          config =
          # lua
          ''
            require("nvim-highlight-colors").setup {
              render = 'virtual',
              virtual_symbol_position = 'eow',
              virtual_symbol_prefix = " ",
              virtual_symbol_suffix = "",
            }
          '';
        }

        {
          plugin = lean-nvim;
          optional = true;
          type = "lua";
          config =
          # lua
          ''
            require("lz.n").load({
              "lean",
              ft = "lean",
              after = function()
                require('lean').setup({ mappings = true })
              end,
            })
          '';
        }

        tmux-nvim
        nvim-lspconfig

        {
          plugin = telescope-nvim;
          optional = true;
          type = "lua";
          config = 
          # lua
          ''
            require("lz.n").load({
              "telescope.nvim",
              cmd = "Telescope",
              after = function()
                require('telescope').setup({})
                require('telescope').load_extension('fzf')
              end,
            })
          '';
        }
        telescope-fzf-native-nvim

        conform-nvim

        # textobjects
        mini-ai
        {
          plugin = mini-pairs;
          type = "lua";
          config =
          # lua
          ''
          require("mini.pairs").setup()
          '';
        }
        {
          plugin = mini-surround;
          type = "lua";
          config =
          # lua
          ''
          require("mini.surround").setup({ silent = true })
          '';
        }
        {
          plugin = mini-trailspace;
          type = "lua";
          config =
          # lua
          ''
          require("mini.trailspace").setup()
          '';
        }
        {
          plugin = mini-splitjoin;
          type = "lua";
          config = 
          # lua 
          ''
          require("mini.splitjoin").setup({
            mappings = { toggle = "", split = "", join = "" },
          })
          '';
        }
        {
          plugin = treesj;
          type = "lua";
          config =
          # lua
          ''
          require("treesj").setup({ use_default_keymaps = false, notify = false})
          --require("lz.n").load({
          --     "treesj",
          --     cmd = {'TSJSplit', 'TSJToggle', 'TSJJoin'},
          --     after = function()
          --       require("treesj").setup(use_default_keymaps = false)
          --     end,
          -- })
          '';
        }
      ];
      extraLuaConfig = 
      ''
        ${builtins.readFile ./nvim/init.lua}
        vim.cmd[[colorscheme ${scheme.name}]]
        vim.opt.runtimepath:prepend('${tsparsers}')
      '';
    };
  };
}
