{
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
        gitignore = false;
      };
    };
  };
}
