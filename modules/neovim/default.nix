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

    # home.sessionVariables.MANPAGER = "nvim +Man!";

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = false;
      vimAlias = false;
      vimdiffAlias = true;
      plugins = with pkgs.vimPlugins; [
        nvim-treesitter
        # nvim-treesitter.withAllGrammars
        (nvim-treesitter.withPlugins (p: with p; [
          tree-sitter-nix
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
        ]))

        {
          plugin = lean-nvim;
          config = 
          # lua
          ''
            require('lean').setup{ mappings = true }
          '';
          type = "lua";
        }
        plenary-nvim
        mini-icons
        oil-nvim
        tmux-nvim
        # noice-nvim
        nvim-lspconfig
        # blink-cmp
        # tinted-vim
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
      extraLuaConfig = 
      ''
        ${builtins.readFile ./nvim/init.lua}
        vim.cmd[[${scheme.extraVimConfig}]]
        vim.cmd[[colorscheme ${scheme.name}]]
      '';
    };
  };
}
