local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

vim.o.timeout = true
vim.o.timeoutlen = 300
require("which-key").setup({})

which_key.register({
  v = {
    name = "[VERSION_CONTROL]"
  }
}, { prefix = "<leader>" })

which_key.register({
  s = {
    name = "[TELESCOPE]",
  }
}, { prefix = "<leader>" })

which_key.register({
  a = {
    name = "[AI]"
  }
}, { prefix = "<leader>" })

which_key.register({
  q = {
    name = "[QUICK_FIX_LIST]"
  }
}, { prefix = "<leader>" })

which_key.register({
  m = {
    name = "[HARPOON]"
  }
}, { prefix = "<leader>" })

which_key.register({
  l = {
    name = "[LSP]"
  }
}, { prefix = "<leader>" })

which_key.register({
  r = {
    name = "[REFACTORING]"
  }
}, { prefix = "<leader>" })

which_key.register({
  d = {
    name = "[DAP]"
  }
}, { prefix = "<leader>" })

which_key.register({
  r = {
    name = "[REFACTORING]"
  }
}, { mode = "v", prefix = "<leader>" })

which_key.register({
  h = {
    name = "[HUNKS]"
  }
}, { prefix = "<leader>" })

which_key.register({
  c = {
    name = "[CHATGPT]",
    c = { "<cmd>ChatGPT<CR>", "[C]hatGPT" },
    e = { "<cmd>ChatGPTEditWithInstruction<CR>", "[E]dit with instruction", mode = { "n", "v" } },
    g = { "<cmd>ChatGPTRun grammar_correction<CR>", "[G]rammar Correction", mode = { "n", "v" } },
    t = { "<cmd>ChatGPTRun translate<CR>", "[T]ranslate", mode = { "n", "v" } },
    k = { "<cmd>ChatGPTRun keywords<CR>", "[K]eywords", mode = { "n", "v" } },
    d = { "<cmd>ChatGPTRun docstring<CR>", "[D]ocstring", mode = { "n", "v" } },
    a = { "<cmd>ChatGPTRun add_tests<CR>", "[A]dd Tests", mode = { "n", "v" } },
    o = { "<cmd>ChatGPTRun optimize_code<CR>", "[O]ptimize Code", mode = { "n", "v" } },
    s = { "<cmd>ChatGPTRun summarize<CR>", "[S]ummarize", mode = { "n", "v" } },
    f = { "<cmd>ChatGPTRun fix_bugs<CR>", "[F]ix Bugs", mode = { "n", "v" } },
    x = { "<cmd>ChatGPTRun explain_code<CR>", "E[x]plain Code", mode = { "n", "v" } },
    r = { "<cmd>ChatGPTRun roxygen_edit<CR>", "[R]oxygen Edit", mode = { "n", "v" } },
    l = { "<cmd>ChatGPTRun code_readability_analysis<CR>", "Code Readability Analysis", mode = { "n", "v" } },
    n = { "<cmd>read !work-commit-message<CR>", "Generate [N]ude Commit Message", mode = { "n", "v" } },
    m = { "<cmd>read !personal-commit-message<CR>", "Generate Commit [M]essage", mode = { "n", "v" } },
  },
}, { prefix = "<leader>" })
