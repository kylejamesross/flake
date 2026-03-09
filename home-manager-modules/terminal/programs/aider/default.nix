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
      };
    };
  };
}
