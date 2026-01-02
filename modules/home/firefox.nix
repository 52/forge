{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (osConfig) wayland;
  inherit (config) home;
in
mkIf wayland.enable {
  env = {
    # Set the default browser.
    BROWSER = "firefox";
    # Enable GPU rendering.
    MOZ_WEBRENDER = "1";
    # Enable Wayland support.
    MOZ_ENABLE_WAYLAND = "1";
  };

  # Enable "Firefox".
  # See: https://www.mozilla.org/en-US/firefox/new
  programs.firefox = {
    enable = true;

    # Set the default user profile.
    profiles.${home.username} = {
      settings = {
        # Disable automatic updates.
        "app.update.auto" = false;
        # Disable automatic background updates.
        "app.update.background.enabled" = false;

        # Restore previous session on startup.
        "browser.startup.page" = 3;
        # Don't ask if this is the default browser.
        "browser.shell.checkDefaultBrowser" = false;
        # Don't switch to a new tab that was opened.
        "browser.tabs.loadBookmarksInBackground" = true;

        # Remove the "Account" button from the toolbar.
        "identity.fxaccounts.toolbar.enabled" = false;
        # Ensure bookmarks toolbar is only visible in a new tab.
        "browser.toolbars.bookmarks.visibility" = "newtab";
        # Disable "Web search" on the Firefox Home page.
        "browser.newtabpage.activity-stream.showSearch" = false;
        # Disable "Shortcuts" on the Firefox Home page.
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        # Enable "userChrome.css" customization support.
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

        # Disable "Ask to save passwords".
        "signon.rememberSignons" = false;
        # Disable "Save and fill addresses".
        "extensions.formautofill.addresses.enabled" = false;
        # Disable "Save and fill payment methods".
        "extensions.formautofill.creditCards.enabled" = false;

        # Disable "Recommend extensions as you browse".
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
        # Disable "Recommend features as you browse".
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
        # Disable the Pocket integration.
        "extensions.pocket.enabled" = false;

        # Disable the master switch for all data reporting.
        "datareporting.policy.dataSubmissionEnabled" = false;
        # Disable the submission of Firefox Health Reports.
        "datareporting.healthreport.uploadEnabled" = false;
        # Disable all telemetry and data collection features.
        "toolkit.telemetry.enabled" = false;
        # Disable the unified telemetry pipeline.
        "toolkit.telemetry.unified" = false;
        # Prevent telemetry data from being sent.
        "toolkit.telemetry.server" = "data:,";
        # Disable telemetry pings related to browser health.
        "toolkit.telemetry.bhrPing.enabled" = false;
        # Disable the archiving of old telemetry pings.
        "toolkit.telemetry.archive.enabled" = false;
        # Disable the telemetry ping sent after an update.
        "toolkit.telemetry.updatePing.enabled" = false;
        # Disable the telemetry ping sent from a new profile.
        "toolkit.telemetry.newProfilePing.enabled" = false;
        # Disable the telemetry ping sent on the first shutdown of a session.
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        # Disable the telemetry ping sender for shutdown events.
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        # Disable participation in Firefox "Studies".
        "app.shield.optoutstudies.enabled" = false;

        # Set the master privacy preset to "Strict".
        "browser.contentblocking.category" = "strict";
        # Enable Total Cookie Protection by partitioning network state.
        "privacy.partition.network_state" = true;
        # Enable the primary Enhanced Tracking Protection feature.
        "privacy.trackingprotection.enabled" = true;
        # Enable protection against cryptomining scripts.
        "privacy.trackingprotection.cryptomining.enabled" = true;
        # Enable protection against email tracking pixels.
        "privacy.trackingprotection.emailtracking.enabled" = true;
        # Enable protection against fingerprinting scripts.
        "privacy.trackingprotection.fingerprinting.enabled" = true;
      };

      # Install browser extensions.
      # See: https://nur.nix-community.org/repos/rycee
      extensions.packages = builtins.attrValues {
        inherit (pkgs.nur.repos.rycee.firefox-addons)
          ublock-origin
          ;
      };
    };
  };
}
