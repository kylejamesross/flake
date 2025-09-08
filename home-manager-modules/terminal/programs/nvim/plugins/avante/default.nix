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
