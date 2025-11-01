{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.neovim;
  scheme = config.modules.scheme;
  tsparsers = pkgs.symlinkJoin {
    # if we don't symlink, startuptime grows by an order of magnitude because of long runtimepath
    name = "tsparsers";
    # paths = (pkgs.vimPlugins.nvim-treesitter.withAllGrammars).dependencies;
    paths =
      (pkgs.vimPlugins.nvim-treesitter.withPlugins (
        p: with p; [
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
          tree-sitter-comment
          tree-sitter-dockerfile
          tree-sitter-make
          tree-sitter-cmake
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
          tree-sitter-latex
        ]
      )).dependencies;
  };
in
{
  options.modules.neovim = {
    enable = lib.mkEnableOption "neovim";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      basedpyright
      clang-tools
      ruff
      nixfmt-rfc-style
      stylua
      black
      isort
      nixd
      lua-language-server
      cmake-language-server
      kdePackages.qtdeclarative
    ];
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

        nvim-treesitter
        tsparsers
        # broken or missing ts parsers
        nvim-treesitter-parsers.qmljs
        nvim-treesitter-parsers.systemverilog
        nvim-treesitter-parsers.prolog


        nvim-lspconfig

        {
          plugin = lazydev-nvim;
          type = "lua";
          config = # lua
          ''
          require("lazydev").setup{}
          '';
        }

        nvim-dap
        nvim-dap-ui

        # colorschemes. TODO: delete
        # base16-nvim
        tinted-nvim

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
          plugin = indent-blankline-nvim;
          optional = false;
          type = "lua";
          config = 
            # lua
            ''
            require('ibl').setup({
              indent = {
                char = '▏',
              },
              scope = { enabled = false },
            })
            '';
        }

        telescope-ui-select-nvim
        {
          plugin = telescope-nvim;
          optional = false;
          type = "lua";
          config =
            # lua
            ''
              -- require("lz.n").load({
              --   "telescope.nvim",
              --   cmd = "Telescope",
              --   after = function()
                  require('telescope').setup({})
                  require('telescope').load_extension('fzf')
                  require('telescope').load_extension('ui-select')
              --   end,
              -- })
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
      # lua
      ''
        ${builtins.readFile ./nvim/init.lua}
        require('tinted-colorscheme').setup({
          base00 = "${scheme.base00}",
          base01 = "${scheme.base01}",
          base02 = "${scheme.base02}",
          base03 = "${scheme.base03}",
          base04 = "${scheme.base04}",
          base05 = "${scheme.base05}",
          base06 = "${scheme.base06}",
          base07 = "${scheme.base07}",
          base08 = "${scheme.base08}",
          base09 = "${scheme.base09}",
          base0A = "${scheme.base0A}",
          base0B = "${scheme.base0B}",
          base0C = "${scheme.base0C}",
          base0D = "${scheme.base0D}",
          base0E = "${scheme.base0E}",
          base0F = "${scheme.base0F}",
          base10 = "${scheme.base10}",
          base11 = "${scheme.base11}",
          base12 = "${scheme.base12}",
          base13 = "${scheme.base13}",
          base14 = "${scheme.base14}",
          base15 = "${scheme.base15}",
          base16 = "${scheme.base16}",
          base17 = "${scheme.base17}",
        }, {
          supports = { tinty = false, live_reload = false },
          highlights = { telescope_borders = true },
        })
        vim.cmd[[doautocmd ColorScheme]]

        vim.opt.runtimepath:prepend('${tsparsers}')
      '';
    };
  };
}
