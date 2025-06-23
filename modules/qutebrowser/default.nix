{ config, lib, pkgs, inputs, ... }:
let
  cfg = config.modules.qutebrowser;
  scheme = config.modules.scheme;
  fg = "${scheme.base05}";
  fg2 = "${scheme.base03}";
  bg = "${scheme.base00}";
  bg2 = "${scheme.base02}";
in
{
  options.modules.qutebrowser = {
    enable = lib.mkEnableOption "qutebrowser";
    wrapWithNixGL = lib.mkEnableOption "NixGL Wrapper";
  };

  config = {
    programs.qutebrowser = lib.mkIf cfg.enable {
      enable = true;
      package = if cfg.wrapWithNixGL then config.lib.nixGL.wrap pkgs.qutebrowser else pkgs.qutebrowser;
      loadAutoconfig = false;
      extraConfig = ''
        ${builtins.readFile ./config.py}
        c.colors.completion.category.bg = "${bg2}"
        c.colors.completion.even.bg = "${bg}"
        c.colors.completion.odd.bg = "${bg}"
        c.colors.completion.category.fg = "${fg}"
        c.colors.completion.item.selected.fg = "${fg}"
        c.colors.completion.item.selected.bg = "${bg}"
        c.colors.completion.item.selected.match.fg = "${fg}"
        c.colors.completion.item.selected.border.top = "${bg}"
        c.colors.completion.item.selected.border.bottom = "${bg}"
        c.colors.completion.fg = "${fg2}"
        c.colors.completion.match.fg = "${fg2}"

        c.colors.downloads.bar.bg = "${bg}"
        c.colors.downloads.bar.bg = "${bg}"
        c.colors.downloads.error.bg = "${scheme.base08}"
        c.colors.downloads.error.fg = "${bg}"
        c.colors.downloads.start.bg = "${bg2}"
        c.colors.downloads.start.fg = "${fg}"
        c.colors.downloads.stop.bg = "${bg2}"
        c.colors.downloads.stop.fg = "${fg}"
        
        c.colors.hints.bg = "${scheme.base0D}"
        c.colors.hints.fg = "${bg}"
        c.colors.hints.match.fg = "${bg2}"

        c.colors.keyhint.bg = "${bg2}"
        c.colors.keyhint.fg = "${fg}"
        c.colors.keyhint.suffix.fg = "${scheme.base0D}"

        c.colors.messages.error.bg = "${scheme.base08}"
        c.colors.messages.error.fg = "${bg}"

        c.colors.prompts.bg = "${bg}"
        c.colors.prompts.selected.bg = "${bg}"
        c.colors.prompts.fg = "${fg2}"
        c.colors.prompts.selected.fg = "${fg2}"
        c.colors.prompts.border = "0px solid grey"

        # c.colors.statusbar.caret.bg = "${scheme.base0E}"
        c.colors.statusbar.caret.bg = "${bg2}"
        c.colors.statusbar.caret.fg = "${fg}"
        c.colors.statusbar.caret.selection.bg = "${bg2}"
        c.colors.statusbar.caret.selection.fg = "${fg}"

        c.colors.statusbar.command.bg = "${bg2}"
        c.colors.statusbar.command.fg = "${fg}"
        c.colors.statusbar.command.private.bg = "${bg2}"
        c.colors.statusbar.command.private.fg = "${fg}"
        c.colors.statusbar.insert.bg = "${bg2}"
        c.colors.statusbar.insert.fg = "${fg}"
        c.colors.statusbar.normal.bg = "${bg2}"
        c.colors.statusbar.normal.fg = "${fg}"
        c.colors.statusbar.passthrough.bg = "${bg2}"
        c.colors.statusbar.passthrough.fg = "${fg}"
        c.colors.statusbar.private.bg = "${bg2}"
        c.colors.statusbar.private.fg = "${fg}"
        c.colors.statusbar.progress.bg = "${bg2}"
        c.colors.statusbar.url.fg = "${fg}"
        c.colors.statusbar.url.success.http.fg = "${fg}"
        c.colors.statusbar.url.success.https.fg = "${fg}"
        c.colors.statusbar.url.warn.fg = "${fg}"
        c.colors.statusbar.url.error.fg = "${scheme.base08}"
        c.colors.statusbar.url.hover.fg = "${scheme.base0D}"

        c.colors.tabs.bar.bg = "${bg}"
        c.colors.tabs.even.bg = "${bg}"
        c.colors.tabs.odd.bg = "${bg}"
        c.colors.tabs.even.fg = "${fg2}"
        c.colors.tabs.odd.fg = "${fg2}"
        c.colors.tabs.selected.even.bg = "${bg}"
        c.colors.tabs.selected.odd.bg = "${bg}"
        c.colors.tabs.selected.even.fg = "${fg}"
        c.colors.tabs.selected.odd.fg = "${fg}"
        c.colors.webpage.bg = "${bg}"
        c.colors.completion.category.border.top = "${bg2}";
        c.colors.completion.category.border.bottom = "${bg2}";
        c.colors.webpage.preferred_color_scheme = "${if scheme.light then "light" else "dark"}"
        c.colors.webpage.darkmode.enabled = ${if scheme.light then "False" else "True"}

        c.hints.border="${fg}"
      '';
    };
  };
}
