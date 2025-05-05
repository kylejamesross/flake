{...}: {
  programs.nixvim = {
    plugins.avante = {
      enable = true;
      settings = {
        provider = "openai";
        openai = {
          model = "gpt-4.1-mini";
        };
      };
    };
  };
}
