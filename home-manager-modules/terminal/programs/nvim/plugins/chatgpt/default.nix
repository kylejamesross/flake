{...}: {
  programs.nixvim = {
    plugins.chatgpt.enable = true;
    keymaps = [
      {
        mode = ["n" "v"];
        key = "<leader>ae";
        action = "<cmd>ChatGPTEditWithInstruction<CR>";
        options = {
          desc = "[E]dit with instruction";
        };
      }
      {
        mode = ["n" "v"];
        key = "<leader>ag";
        action = "<cmd>ChatGPTRun grammar_correction<CR>";
        options = {
          desc = "[G]rammar Correction";
        };
      }
      {
        mode = ["n" "v"];
        key = "<leader>an";
        action = "<cmd>ChatGPTRun tra[n]slate<CR>";
        options = {
          desc = "[T]ranslate";
        };
      }
      {
        mode = ["n" "v"];
        key = "<leader>ak";
        action = "<cmd>ChatGPTRun keywords<CR>";
        options = {
          desc = "[K]eywords";
        };
      }
      {
        mode = ["n" "v"];
        key = "<leader>ad";
        action = "<cmd>ChatGPTRun docstring<CR>";
        options = {
          desc = "[D]ocstring";
        };
      }
      {
        mode = ["n" "v"];
        key = "<leader>at";
        action = "<cmd>ChatGPTRun add_tests<CR>";
        options = {
          desc = "Add [T]ests";
        };
      }
      {
        mode = ["n" "v"];
        key = "<leader>ao";
        action = "<cmd>ChatGPTRun optimize_code<CR>";
        options = {
          desc = "[O]ptimize Code";
        };
      }
      {
        mode = ["n" "v"];
        key = "<leader>as";
        action = "<cmd>ChatGPTRun summarize<CR>";
        options = {
          desc = "[S]ummarize";
        };
      }
      {
        mode = ["n" "v"];
        key = "<leader>af";
        action = "<cmd>ChatGPTRun fix_bugs<CR>";
        options = {
          desc = "[F]ix Bugs";
        };
      }
      {
        mode = ["n" "v"];
        key = "<leader>ax";
        action = "<cmd>ChatGPTRun explain_code<CR>";
        options = {
          desc = "E[x]plain Code";
        };
      }
      {
        mode = ["n" "v"];
        key = "<leader>ar";
        action = "<cmd>ChatGPTRun roxygen_edit<CR>";
        options = {
          desc = "[R]oxygen Edit";
        };
      }
      {
        mode = ["n" "v"];
        key = "<leader>al";
        action = "<cmd>ChatGPTRun code_readability_analysis<CR>";
        options = {
          desc = "Code Readabi[l]ity Analysis";
        };
      }
    ];
  };
}
