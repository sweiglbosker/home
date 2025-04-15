{ config, lib, pkgs, ...}:
let
  cfg = config.modules.neovim;
  scheme = config.modules.scheme;
  fromGitHub = ref: repo: pkgs.vimUtils.buildVimPlugin {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
    };
    doCheck = false;
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

    xdg.configFile."nvim/colors" = {
      source = ./nvim/colors;
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
        nvim-treesitter.withAllGrammars
        # (nvim-treesitter.withPlugins (p: with p; [
        #   tree-sitter-nix
        #   tree-sitter-make
        #   tree-sitter-verilog
        #   tree-sitter-scheme
        #   tree-sitter-llvm
        #   tree-sitter-html
        #   tree-sitter-glsl
        #   tree-sitter-devicetree
        #   tree-sitter-cuda
        #   tree-sitter-c
        #   tree-sitter-cpp
        #   tree-sitter-lua
        #   tree-sitter-zig
        #   tree-sitter-rust
        #   tree-sitter-toml
        #   tree-sitter-markdown
        #   tree-sitter-markdown-inline
        # ]))

        {
          plugin = lean-nvim;
          config = ''
            require('lean').setup{ mappings = true }
          '';
          type = "lua";
        }
        plenary-nvim
        mini-icons
        oil-nvim
        nvim-lspconfig
        base16-nvim
        telescope-nvim
        telescope-fzf-native-nvim
        # fzf-lua
#        https://github.com/ibhagwan/fzf-lua/commit/26095d98c2969730457bf5b483919280e2cfb8bb
        # (fromGitHub "HEAD" "ibhagwan/fzf-lua")
        # fzf-lua.overrideAttrs (finalAttrs: previousAttrs: {
        #    previousAttrs.doCheck = false;
        # })
        vim-obsession
        (pkgs.neovimUtils.buildNeovimPlugin {
          luaAttr = pkgs.luaPackages.fzf-lua;
          doCheck = false;
        })
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
        hi LineNr guifg=${scheme.base02}
        hi LineNrAbove guifg=${scheme.base02}
        hi LineNrBelow guifg=${scheme.base02}
        ]]

        ${builtins.readFile ./nvim/init.lua}
        vim.cmd[[${scheme.extraVimConfig}]]
      '';
    };
  };
}
