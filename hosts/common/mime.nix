{...}: {
  xdg.mimeApps = {
    enable = true;
    defaultApplications = let
      textEditors = ["notepadqq.desktop"];
      browsers = ["firefox.desktop"];
      mailClients = ["userapp-Thunderbird-WKLTC2.desktop"];
      imageViewers = ["swappy.desktop" "gimp.desktop"];
      videoViewers = ["vlc.desktop"];
    in {
      "inode/directory" = ["org.kde.dolphin.desktop"];
      "text/plain" = textEditors;
      "text/markdown" = textEditors;
      "text/xml" = textEditors;
      "text/x-markdown" = textEditors;
      "text/x-readme" = textEditors;
      "text/x-changelog" = textEditors;
      "text/x-copying" = textEditors;
      "text/x-install" = textEditors;
      "text/html" = browsers;
      "image/png" = imageViewers;
      "image/jpeg" = imageViewers;
      "image/gif" = browsers;
      "image/bmp" = imageViewers;
      "image/x-portable-pixmap" = imageViewers;
      "image/x-portable-bitmap" = imageViewers;
      "image/x-portable-graymap" = imageViewers;
      "image/x-portable-anymap" = imageViewers;
      "x-terminal-emulator" = ["kitty"];
      "x-scheme-handler/http" = browsers;
      "x-scheme-handler/https" = browsers;
      "x-scheme-handler/chrome" = browsers;
      "x-scheme-handler/vscode" = ["code-url-handler.desktop"];
      "x-scheme-handler/mailto" = mailClients;
      "x-scheme-handler/x-github-client" = ["github-desktop.desktop"];
      "x-scheme-handler/mid" = mailClients;
      "x-scheme-handler/x-github-desktop-auth" = ["github-desktop.desktop"];
      "application/x-extension-htm" = browsers;
      "application/x-extension-html" = browsers;
      "application/x-extension-shtml" = browsers;
      "application/x-extension-xht" = browsers;
      "application/x-extension-xhtml" = browsers;
      "application/xhtml+xml" = browsers;
      "application/xml" = browsers;
      "message/rfc822" = mailClients;
      "audio/flac" = videoViewers;
      "audio/mp4" = videoViewers;
      "audio/mpeg" = videoViewers;
      "audio/x-aiff" = videoViewers;
      "audio/x-wav" = videoViewers;
      "application/pdf" = "okularApplication_pdf.desktop";
      "image/svg+xml" = "org.inkscape.Inkscape.desktop";
    };
  };
}
