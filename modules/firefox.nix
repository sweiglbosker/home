{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.firefox;
  scheme = config.modules.scheme;
  fmt = col: lib.strings.removePrefix "#" col;
  lock-false = {
    Value = false;
    Status = "locked";
  };
  lock-true = {
    Value = true;
    Status = "locked";
  };
  lock-empty-string = {
    Value = "";
    Status = "locked";
  };
in
{
  options.modules.firefox = {
    enable = lib.mkEnableOption "firefox";
  };

  config = {
    programs.firefox = lib.mkIf cfg.enable {
      enable = true;
      nativeMessagingHosts = [
        pkgs.tridactyl-native
        pkgs.passff-host
      ];
      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        SearchBar = "unified";
        DisablePocket = true;
        DisableFirefoxAccounts = true;
        DisableAccounts = true;
        DisableFirefoxScreenshots = true;
        OverrideFirstRunPag = "";
        OverridePostUpdatePag = "";
        DisplayBookmarksToolbar = "never";
        DisplayMenuBar = "default-off";

        ExtensionSettings = {
          "tridactyl.vim.betas@cmcaine.co.uk" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/file/4405615/tridactyl_vim-1.24.2.xpi";
            installation_mode = "force_installed";
          };
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/file/4492375/ublock_origin-1.64.0.xpi";
            installation_mode = "force_installed";
          };
        };

        Preferences = {
          "browser.contentblocking.category" = {
            Value = "strict";
            Status = "locked";
          };
          "extensions.pocket.enabled" = lock-false;
          "extensions.screenshots.disabled" = lock-true;
          "browser.topsites.contile.enabled" = lock-false;
          "browser.formfill.enable" = lock-false;
          "browser.search.suggest.enabled" = lock-false;
          "browser.search.suggest.enabled.private" = lock-false;
          "browser.urlbar.suggest.searches" = lock-false;
          "browser.urlbar.showSearchSuggestionsFirst" = lock-false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = lock-false;
          "browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeVisited" = lock-false;
          "browser.newtabpage.activity-stream.showSponsored" = lock-false;
          "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
          "sidebar.verticalTabs" = lock-true;
          "sidebar.visibility" = "expand-on-hover";
          "sidebar.animation.enabled" = "false";
          "sidebar.main.tools" = "";
        };
      };
    };
  };
}
