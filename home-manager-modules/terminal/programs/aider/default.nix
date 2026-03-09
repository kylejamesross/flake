{config, ...}: let
  colors = config.lib.stylix.colors.withHashtag;
in {
  programs = {
    aider-chat = {
      enable = true;
      settings = {
        model = "gpt-5.4";
        "weak-model" = "gpt-5-mini";
        "dark-mode" = true;
        editor = "nvim";
        "auto-commits" = false;
        pretty = true;
        "user-input-color" = colors.green;
        "tool-output-color" = colors.base00;
        "tool-error-color" = colors.red;
        "tool-warning-color" = colors.yellow;
        "assistant-output-color" = colors.blue;
        "completion-menu-bg-color" = colors.base07;
        "completion-menu-color" = colors.base00;
        "completion-menu-current-bg-color" = colors.green;
        "completion-menu-current-color" = colors.base00;
        gitignore = false;
      };
    };
  };
}
