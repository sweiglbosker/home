{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.aerc;
in
{
  options.modules.aerc = {
    enable = lib.mkEnableOption "aerc";
  };
  config = lib.mkIf cfg.enable {
    programs.aerc = {
      enable = true;
      extraConfig = {
        general = {
          unsafe-accounts-conf = true;
          default-menu-cmd = "fzf --tmux";
        };
        ui = {
          this-day-time-format="03:04 PM";
          this-year-time-format="2006-01-02";
          dirlist-tree=true;
          dirlipse-collapse=1;
          sidebar-width = 20;
        };
        "ui:folder=Sent" = {
          index-columns = "date<20,name<17,flags>4,subject<*";
          column-name = "{{index (.To | names) 0}}";
        };
        filters = {
          "subject,~^\\[PATCH"="hldiff";
          "subject,~^\\[RFC"="hldiff";
          "text/*" = "plaintext";
          "text/calendar" = "calendar";
          "text/html" = "html | colorize";
          "message/delivery-status" = "colorize";
          "message/rfc822" = "colorize";
        };
        viewer = {
          # pager = "nvim +Man!";
          pager = "less -Rc";
        };
      };
      extraBinds = {
        global = {
          "\\[t" = ":prev-tab<Enter>";
          "\\]t" = ":next-tab<Enter>";
          "<C-t>" = ":term<Enter>";
          "<C-?>" = ":help keys<Enter>";
          "<C-c>" = ":prompt 'Quit?' quit<Enter>";
          "<C-q>" = ":prompt 'Quit?' quit<Enter>";
          "<C-z>" = ":suspend<Enter>";
        };

        "messages:folder=Drafts"."<Enter>" = ":recall<Enter>";
        messages = {
          /**
            * CUSTOM SECTION **
          */
          "n" = ":next<Enter>";
          "e" = ":prev<Enter>";
          N = ":next-folder<enter>";
          E = ":prev-folder<enter>";
          j = ":next-result<enter>";
          J = ":prev-result<enter>";
          /**
            *               **
          */
          g = ":select 0<Enter>";
          G = ":select -1<Enter>";

          "T" = ":toggle-threads<Enter>";
          "zc" = ":fold<Enter>";
          "zo" = ":unfold<Enter>";
          "za" = ":fold -t<Enter>";
          "zM" = ":fold -a<Enter>";
          "zR" = ":unfold -a<Enter>";
          "<tab>" = ":fold -t<Enter>";
          "<Enter>" = ":view<Enter>";
          "d" = ":choose -o y 'Really delete this message' delete-message<Enter>";
          "D" = ":delete<Enter>";
          "a" = ":archive flat<Enter>";
          "A" = ":unmark -a<Enter>:mark -T<Enter>:archive flat<Enter>";
          "C" = ":compose<Enter>";
          "b" = ":bounce<space>";

          "rr" = ":reply -a<Enter>";
          "rq" = ":reply -aq<Enter>";
          "Rr" = ":reply<Enter>";
          "Rq" = ":reply -q<Enter>";

          "c" = ":cf<space>";
          "$" = ":term<space>";
          "!" = ":term<space>";
          "|" = ":pipe<space>";

          "/" = ":search<space>";
          "\\" = ":filter<space>";
          "<Esc>" = ":clear<Enter>";

          "s" = ":split<Enter>";
          "S" = ":vsplit<Enter>";

          "pl" = ":patch list<Enter>";
          "pa" = ":patch apply <Tab>";
          "pd" = ":patch drop <Tab>";
          "pb" = ":patch rebase<Enter>";
          "pt" = ":patch term<Enter>";
          "ps" = ":patch switch <Tab>";
        };
        view = {
          "/" = ":toggle-key-passthrough<Enter>/";
          "q" = ":close<Enter>";
          "O" = ":open<Enter>";
          "o" = ":open<Enter>";
          "S" = ":save<space>";
          "|" = ":pipe<space>";
          "D" = ":delete<Enter>";
          "A" = ":archive flat<Enter>";

          "<C-y>" = ":copy-link <space>";
          "<C-l>" = ":open-link <space>";

          "f" = ":forward<Enter>";
          "rr" = ":reply -a<Enter>";
          "rq" = ":reply -aq<Enter>";
          "Rr" = ":reply<Enter>";
          "Rq" = ":reply -q<Enter>";

          "H" = ":toggle-headers<Enter>";
          "<C-e>" = ":prev-part<Enter>";
          "<C-n>" = ":next-part<Enter>";
          "N" = ":next<Enter>";
          "E" = ":prev<Enter>";
        };
        compose = {
          "$noinherit" = "true";
          "$ex" = "<C-x>";
          "$complete" = "<C-o>";
          "<C-n>" = ":next-field<Enter>";
          "<C-e>" = ":prev-field<Enter>";
          "<C-Left>" = ":switch-account -p<Enter>";
          "<C-Right>" = ":switch-account -n<Enter>";
          "<tab>" = ":next-field<Enter>";
          "<backtab>" = ":prev-field<Enter>";
          "<C-PgUp>" = ":prev-tab<Enter>";
          "<C-PgDn>" = ":next-tab<Enter>";
        };
        "compose::review" = {
          "y" = ":send<Enter>";
          "n" = ":abort<Enter>";
          "s" = ":sign<Enter>";
          "x" = ":encrypt<Enter>";
          "v" = ":preview<Enter>";
          "p" = ":postpone<Enter>";
          "q" = ":choose -o d discard abort -o p postpone postpone<Enter>";
          "e" = ":edit<Enter>";
          "a" = ":attach<space>";
          "d" = ":detach<space>";
        };
        "compose::editor" = {
          "$noinherit" = "true";
          "$ex" = "<C-x>";
        };
        terminal = {
          "$noinherit" = "true";
          "$ex" = "<C-x>";
          "<C-p>" = ":prev-tab<Enter>";
          "<C-n>" = ":next-tab<Enter>";
        };
      };
    };
  };
}
