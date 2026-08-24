{
  config,
  lib,
  pkgs,
  theme,
  ...
}: let
  c = config.lib.stylix.colors;
  wtSettingsPath = "/mnt/c/Users/KRoss/AppData/Local/Packages/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState/settings.json";

  scheme = {
    name = theme;
    background = "#${c.base00}";
    foreground = "#${c.base05}";
    black = "#${c.base00}";
    red = "#${c.base08}";
    green = "#${c.base0B}";
    yellow = "#${c.base0A}";
    blue = "#${c.base0D}";
    purple = "#${c.base0E}";
    cyan = "#${c.base0C}";
    white = "#${c.base05}";
    brightBlack = "#${c.base03}";
    brightRed = "#${c.base08}";
    brightGreen = "#${c.base0B}";
    brightYellow = "#${c.base0A}";
    brightBlue = "#${c.base0D}";
    brightPurple = "#${c.base0E}";
    brightCyan = "#${c.base0C}";
    brightWhite = "#${c.base07}";
    cursorColor = "#${c.base05}";
    selectionBackground = "#${c.base02}";
  };
  schemeJson = builtins.toJSON scheme;
in {
  home.activation.themeWindowsTerminal = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ -f "${wtSettingsPath}" ]; then
      ${pkgs.jq}/bin/jq \
        --argjson scheme '${schemeJson}' \
        '.schemes = ((.schemes // []) | map(select(.name != $scheme.name)) + [$scheme])
         | .profiles.defaults.colorScheme = $scheme.name' \
        "${wtSettingsPath}" > "${wtSettingsPath}.tmp" \
      && mv "${wtSettingsPath}.tmp" "${wtSettingsPath}"
    fi
  '';
}
