{ config, lib, pkgs, startup ? [], ...}:
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
  grammarMatcher = yes: builtins.filter (drv: let
    # NOTE: matches if pkgs.neovimUtils.grammarToPlugin was called on it.
    cond = (builtins.match "^vimplugin-treesitter-grammar-.*" "${lib.getName drv}") != null;
    match = if yes then cond else ! cond;
  in
  if drv ? outPath then match else ! yes);

  start = grammarMatcher false startup;
  collected_grammars = grammarMatcher true startup;

  ts_grammars_combined = pkgs.symlinkJoin {
    name = "all-treesitter-grammars";
    paths = map (e: e.outPath) collected_grammars;
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

    programs.neovim = 
    {
      enable = true;
      defaultEditor = true;
      viAlias = false;
      vimAlias = false;
      vimdiffAlias = true;
      # allGrammars = pkgs.symlinkJoin {
      #   name = "allgrammars";
      #   paths = builtins.attrValues pkgs.vimPlugins.nvim-treesitter.grammarPlugins;
      # };
      plugins = with pkgs.vimPlugins; [
        # nvim-treesitter.withAllGrammars
        nvim-treesitter.withPlugins (p: pkgs.symlinkJoin {
          name = "allgrammars";
          paths = builtins.attrValues pkgs.vimPlugins.nvim-treesitter.grammarPlugins;
        })
            # p.tree-sitter-nix
            # p.tree-sitter-verilog
            # p.tree-sitter-llvm
            # p.tree-sitter-cuda
            # p.tree-sitter-cpp
            # p.tree-sitter-c
            # p.tree-sitter-lua
            # p.tree-sitter-zig
            # p.tree-sitter-haskell
            # p.tree-sitter-markdown
            # p.tree-sitter-tablegen
        lz-n

        {
          plugin = lean-nvim;
          optional = true;
          type = "lua";
        }

        {
          plugin = plenary-nvim;
          optional = true;
        }
        tmux-nvim
        base16-nvim
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
          })
          '';
        }
      ];
      extraLuaConfig = 
      # lua
      ''
        ${builtins.readFile ./nvim/init.lua}
        vim.cmd[[colorscheme ${scheme.name}]]
      '';
      extraPackages = [ pkgs.ripgrep pkgs.gcc ];
    };
  };
}
