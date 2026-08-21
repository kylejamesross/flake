{
  pkgs,
  user,
  ...
}: {
  stylix.targets.firefox = {
    profileNames = ["kyle"];
    firefoxGnomeTheme.enable = true;
  };
  programs = {
    firefox = {
      enable = true;
      configPath = ".mozilla/firefox";
      profiles.kyle = {
        name = "Kyle Ross";
        isDefault = true;
        extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          raindropio
          bitwarden
          react-devtools
          reduxdevtools
          vimium
          torrent-control
          enhancer-for-youtube
          untrap-for-youtube
          return-youtube-dislikes
          sponsorblock
        ];
        search = {
          default = "ddg";
          force = true;
          engines = {
            "ddg" = {
              urls = [
                {
                  template = "https://duckduckgo.com/?q={searchTerms}";
                  params = [];
                }
              ];
              definedAliases = ["@d"];
            };
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              definedAliases = ["@n"];
            };
            "Wikipedia" = {
              urls = [
                {
                  template = "https://en.wikipedia.org/wiki/Special:Search";
                  params = [
                    {
                      name = "search";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              definedAliases = ["@w"];
            };
          };
        };
        settings = {
          #### FASTFOX (performance) ####
          # general
          "gfx.content.skia-font-cache-size" = 20;
          "content.notify.interval" = 100000;
          # gfx
          "gfx.canvas.accelerated.cache-size" = 512;
          # js
          "javascript.options.baselinejit.threshold" = 50;
          # media cache
          "media.cache_readahead_limit" = 3600;
          "media.cache_resume_threshold" = 1800;
          # image cache
          "image.mem.decode_bytes_at_a_time" = 32768;
          # networking
          "network.buffer.cache.size" = 65535;
          "network.buffer.cache.count" = 48;
          "network.http.max-connections" = 1800;
          "network.http.max-persistent-connections-per-server" = 10;
          "network.http.max-urgent-start-excessive-connections-per-host" = 5;
          "network.http.request.max-start-delay" = 5;
          "network.dnsCacheExpiration" = 3600;

          #### SECUREFOX (privacy & security) ####
          # tracking protection
          "browser.contentblocking.category" = "strict";
          "browser.download.start_downloads_in_tmp_dir" = true;
          "browser.uitour.enabled" = false;
          "privacy.globalprivacycontrol.enabled" = true;
          # ocsp & certs
          "security.OCSP.enabled" = 0;
          "privacy.antitracking.isolateContentScriptResources" = true;
          "security.csp.reporting.enabled" = false;
          # ssl / tls
          "security.ssl.treat_unsafe_negotiation_as_broken" = true;
          "browser.xul.error_pages.expert_bad_cert" = true;
          "security.tls.enable_0rtt_data" = false;
          # disk avoidance
          "browser.cache.disk.enable" = false;
          "browser.privatebrowsing.forceMediaMemoryCache" = true;
          "media.memory_cache_max_size" = 65536;
          "browser.sessionstore.interval" = 60000;
          # shutdown & sanitizing
          "privacy.history.custom" = true;
          # speculative loading
          "network.http.speculative-parallel-limit" = 0;
          "network.dns.disablePrefetch" = true;
          "network.dns.disablePrefetchFromHTTPS" = true;
          "browser.urlbar.speculativeConnect.enabled" = false;
          "browser.places.speculativeConnect.enabled" = false;
          "network.prefetch-next" = false;
          # search / url bar
          "browser.urlbar.trimHttps" = true;
          "browser.urlbar.untrimOnUserInteraction.featureGate" = true;
          "browser.search.separatePrivateDefault.ui.enabled" = true;
          "browser.search.suggest.enabled" = false;
          "browser.urlbar.quicksuggest.enabled" = false;
          "browser.urlbar.groupLabels.enabled" = false;
          "browser.formfill.enable" = false;
          "network.IDN_show_punycode" = true;
          # https-only mode
          "dom.security.https_only_mode" = true;
          "dom.security.https_only_mode_error_page_user_suggestions" = true;
          # passwords
          "signon.formlessCapture.enabled" = false;
          "signon.privateBrowsingCapture.enabled" = false;
          "network.auth.subresource-http-auth-allow" = 1;
          "editor.truncate_user_pastes" = false;
          # extensions
          "extensions.enabledScopes" = 5;
          # headers / referers
          "network.http.referer.XOriginTrimmingPolicy" = 2;
          # containers
          "privacy.userContext.ui.enabled" = true;
          # various
          "pdfjs.enableScripting" = false;
          # safe browsing
          "browser.safebrowsing.downloads.remote.enabled" = false;
          # mozilla
          "permissions.default.desktop-notification" = 2;
          "permissions.default.geo" = 2;
          "geo.provider.network.url" = "https://beacondb.net/v1/geolocate";
          "browser.search.update" = false;
          "permissions.manager.defaultsUrl" = "";
          "extensions.getAddons.cache.enabled" = false;
          # telemetry
          "datareporting.policy.dataSubmissionEnabled" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "datareporting.usage.uploadEnabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.server" = "data:,";
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false;
          "toolkit.telemetry.shutdownPingSender.enabled" = false;
          "toolkit.telemetry.updatePing.enabled" = false;
          "toolkit.telemetry.bhrPing.enabled" = false;
          "toolkit.telemetry.firstShutdownPing.enabled" = false;
          "toolkit.telemetry.coverage.opt-out" = true;
          "toolkit.coverage.opt-out" = true;
          "toolkit.coverage.endpoint.base" = "";
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.newtabpage.activity-stream.telemetry" = false;
          # experiments
          "app.shield.optoutstudies.enabled" = false;
          "app.normandy.enabled" = false;
          "app.normandy.api_url" = "";
          # crash reports
          "breakpad.reportURL" = "";
          "browser.tabs.crashReporting.sendReport" = false;

          #### PESKYFOX (UI / distractions) ####
          # mozilla ui
          "extensions.getAddons.showPane" = false;
          "extensions.htmlaboutaddons.recommendations.enabled" = false;
          "browser.discovery.enabled" = false;
          "browser.shell.checkDefaultBrowser" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
          "browser.preferences.moreFromMozilla" = false;
          "browser.aboutConfig.showWarning" = false;
          "browser.startup.homepage_override.mstone" = "ignore";
          "browser.aboutwelcome.enabled" = false;
          "browser.profiles.enabled" = true;
          # theme adjustments
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "browser.compactmode.show" = true;
          "browser.privateWindowSeparation.enabled" = false;
          # ai
          "browser.ai.control.default" = "blocked";
          "browser.ml.enable" = false;
          "browser.ml.chat.enabled" = false;
          "browser.ml.chat.menu" = false;
          "browser.tabs.groups.smart.enabled" = false;
          "browser.ml.linkPreview.enabled" = false;
          # fullscreen notice
          "full-screen-api.transition-duration.enter" = "0 0";
          "full-screen-api.transition-duration.leave" = "0 0";
          "full-screen-api.warning.timeout" = 0;
          # url bar
          "browser.urlbar.trending.featureGate" = false;
          # new tab page
          "browser.newtabpage.activity-stream.default.sites" = "";
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredCheckboxes" = false;
          # downloads
          "browser.download.manager.addToRecentDocs" = false;
          # pdf
          "browser.download.open_pdf_attachments_inline" = true;
          # tab behavior
          "browser.bookmarks.openInTabClosesMenu" = false;
          "findbar.highlightAll" = true;

          #### SMOOTHFOX ("natural smooth scrolling v3", 120hz+ displays) ####
          "apz.overscroll.enabled" = true;
          "general.smoothScroll" = true;
          "general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS" = 12;
          "general.smoothScroll.msdPhysics.enabled" = true;
          "general.smoothScroll.msdPhysics.motionBeginSpringConstant" = 600;
          "general.smoothScroll.msdPhysics.regularSpringConstant" = 650;
          "general.smoothScroll.msdPhysics.slowdownMinDeltaMS" = 25;
          "general.smoothScroll.msdPhysics.slowdownMinDeltaRatio" = "2";
          "general.smoothScroll.msdPhysics.slowdownSpringConstant" = 250;
          "general.smoothScroll.currentVelocityWeighting" = "1";
          "general.smoothScroll.stopDecelerationWeighting" = "1";
          "mousewheel.default.delta_multiplier_y" = 300;

          #### PERSONAL OVERRIDES (beyond BetterFox baseline) ####
          # extra privacy / tracking hardening
          "urlclassifier.trackingSkipURLs" = "*.reddit.com, *.twitter.com, *.twimg.com, *.tiktok.com";
          "urlclassifier.features.socialtracking.skipURLs" = "*.instagram.com, *.twitter.com, *.twimg.com";
          "privacy.partition.bloburl_per_partition_key" = true;
          "security.insecure_connection_text.enabled" = true;
          "security.insecure_connection_text.pbmode.enabled" = true;
          "security.mixed_content.block_display_content" = true;
          "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
          "media.peerconnection.ice.default_address_only" = true;
          "identity.fxaccounts.enabled" = false;
          "webchannel.allowObject.urlWhitelist" = "";
          "captivedetect.canonicalURL" = "";
          "network.captive-portal-service.enabled" = false;
          "network.connectivity-service.enabled" = false;
          "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
          "dom.security.sanitizer.enabled" = true;
          # password manager disabled (using Bitwarden instead)
          "signon.rememberSignons" = false;
          "extensions.formautofill.addresses.enabled" = false;
          "extensions.formautofill.creditCards.enabled" = false;
          # ui / ux
          "browser.tabs.firefox-view" = false;
          "browser.tabs.tabmanager.enabled" = false;
          "browser.display.focus_ring_on_anything" = true;
          "browser.display.focus_ring_style" = 0;
          "browser.display.focus_ring_width" = 0;
          "layout.css.prefers-color-scheme.content-override" = 2;
          "app.update.suppressPrompts" = true;
          "browser.privatebrowsing.vpnpromourl" = "";
          "extensions.postDownloadThirdPartyPrompt" = false;
          "cookiebanners.service.mode" = 2;
          "cookiebanners.service.mode.privateBrowsing" = 2;
          "browser.translations.enable" = true;
          "browser.urlbar.suggest.engines" = false;
          "browser.urlbar.suggest.topsites" = false;
          "browser.urlbar.suggest.calculator" = true;
          "browser.urlbar.unitConversion.enabled" = true;
          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          "extensions.pocket.enabled" = false;
          "browser.menu.showViewImageInfo" = true;
          "browser.tabs.tabMinWidth" = 66;
          "browser.tabs.tabClipWidth" = 86;
          "browser.uidensity" = 1;
          # downloads / pdf
          "browser.download.useDownloadDir" = false;
          "browser.download.always_ask_before_handling_new_types" = true;
          "browser.download.alwaysOpenPanel" = false;
          "pdfjs.sidebarViewOnLoad" = 2;
          "browser.download.lastDir" = "/home/${user}/downloads";
          # startup / session
          "browser.startup.blankWindow" = true;
          "browser.sessionstore.restore_on_demand" = false;
          "browser.sessionstore.resume_from_crash" = false;
          "browser.startup.homepage" = "https://homarr.kylejamesross.com";
          "browser.startup.page" = 1;
          "startup.homepage_welcome_url" = "";
          # bookmarks / new tab
          "browser.bookmarks.addedImportButton" = false;
          "browser.toolbars.bookmarks.showOtherBookmarks" = false;
          "browser.urlbar.shortcuts.bookmarks" = false;
          "browser.urlbar.suggest.bookmark" = false;
          "browser.migrate.bookmarks-file.enabled" = false;
          "browser.newtabpage.enabled" = false;
          "alerts.useSystemBackend" = true;
          "browser.preferences.search" = false;
        };
      };
    };
  };
}
