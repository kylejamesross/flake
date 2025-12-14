{...}: {
  programs.nixvim = {
    plugins.avante = {
      enable = true;
      settings = {
        provider = "openai";
        providers = {
          openai = {
            model = "gpt-5-mini";
          };
        };
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<Leader>aC";
        action = ":AvanteClear<CR>";
        options = {
          noremap = true;
          silent = true;
          desc = "avante: clear";
        };
      }
      {
        mode = "n";
        key = "<Leader>ta";
        action = ":AvanteToggle<CR>";
        options = {
          noremap = true;
          silent = true;
          desc = "[T]oggle [A]vante";
        };
      }
    ];
  };
}
