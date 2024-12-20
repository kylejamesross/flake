{...}: {
  programs.nixvim = {
    plugins = {
      neotest = {
        enable = true;
        adapters = {
          vitest.enable = true;
        };
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>de";
        action.__raw = ''
          function () require("neotest").run.run(vim.fn.expand("%")) end
        '';
        options = {
          desc = "Run [E]xpanding Test(s)";
        };
      }
      {
        mode = "n";
        key = "<leader>dl";
        action.__raw = ''
          function() require("neotest").run.run_last() end
        '';
        options = {
          desc = "Run [L]ast Test(s)";
        };
      }
      {
        mode = "n";
        key = "<leader>dt";
        action.__raw = ''
          function() require("neotest").run.run() end
        '';
        options = {
          desc = "Run [T]est";
        };
      }
      {
        mode = "n";
        key = "<leader>dd";
        action.__raw = ''
          function() require("neotest").run.run({ strategy='dap' }) end
        '';
        options = {
          desc = "Run [T]est";
        };
      }
      {
        mode = "n";
        key = "<leader>tt";
        action.__raw = ''
          function() require("neotest").output_panel.toggle() end
        '';
        options = {
          desc = "[T]oggle [T]est Panel";
        };
      }
    ];
  };
}
