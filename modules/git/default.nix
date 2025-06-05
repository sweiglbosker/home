{ config, lib, pkgs, ... }:
let
  cfg = config.modules.git;
in
{
  options.modules.git = {
    enable = lib.mkEnableOption "git";
  };

  config = lib.mkIf cfg.enable {
    # home.packages = with pkgs; [
    # ];
    programs.git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;
      userName = "Stefan Weigl-Bosker";
      userEmail = "stefan@s00.xyz";
      aliases = {
        co = "checkout";
        ri = "rebase -i";
        ag = "add -g";
        ac = "commit --ammend";
        pushf = "push --force-with-lease";
      };
      delta = {
        enable = true;
        options = {
          "syntax-theme" = "base16-256";
          navigate = true;
          dark = true;
        };
      };
#      extraConfig = {};
      # hooks = {
      #    pre-commit = ;
      # };
      ignores = [
        "*.swp"
        "*.swo"
        "*.swf"
        "*~"
        "*.tmp"
        "Session.vim"
        ".envrc"
        ".direnv/"
        ".ignore/"
        ".cache/"
        "*.o"
        "*.a"
        "*.so"
        "*.ko"
        "*.lib"
        # "*.out"
        # "*.elf"
      ];
      signing = {
       signByDefault = true;
      };
      extraConfig = {
        init.defaultBranch = "main";
        merge.conflictStyle = "zdiff3";
        pull.rebase = true;
        push.autoSetupRemote = true;
        rebase = {
          autoSquash = true;
          updateRefs = true;
        };
        fetch = {
          prune = true;
          pruneTags = true;
          all = true;
        };
        url = {
          "ssh://git@s00.xyz:".insteadOf = "g:/";
          "ssh://git@github.com:sweiglbosker/".insteadOf = "gh:/";
          "ssh://git@github.com:".insteadOf = "gh:";
        };
      };
    };
  };
}
