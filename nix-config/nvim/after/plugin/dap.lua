local ok, dap = pcall(require, "dap")
if not ok then
  return
end

dap.adapters.coreclr = {
  type = 'executable',
  command = '/etc/profiles/per-user/kyle/bin/netcoredbg',
  args = { '--interpreter=vscode' }
}

dap.configurations.cs = {
  {
    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/**/*.dll', 'file')
    end,
    env = {
      ASPNETCORE_ENVIRONMENT = "Development",
      ASPNETCORE_URLS = "https://localhost:7132;http://localhost:5185",
    }
  },
}

vim.keymap.set("n", "<F5>", "<CMD>lua require('dap').continue()<CR>",
  { noremap = true, silent = true, desc = "Continue (DAP)" })
vim.keymap.set("n", "<F10>", "<CMD>lua require('dap').step_over()<CR>",
  { noremap = true, silent = true, desc = "Step over (DAP)" })
vim.keymap.set("n", "<F11>", "<CMD>lua require('dap').step_into()<CR>",
  { noremap = true, silent = true, desc = "Step into (DAP)" })
vim.keymap.set("n", "<F12>", "<CMD>lua require('dap').step_out()<CR>",
  { noremap = true, silent = true, desc = "Step out (DAP)" })
vim.keymap.set("n", "<Leader>db", "<CMD>lua require('dap').toggle_breakpoint()<CR>",
  { noremap = true, silent = true, desc = "Toggle breakpoint (DAP)" })
vim.keymap.set("n", "<Leader>dB",
  "<CMD>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
  { noremap = true, silent = true, desc = "Set breakpoint (DAP)" })
vim.keymap.set("n", "<Leader>dr", "<CMD>lua require('dap').repl_open()<CR>",
  { noremap = true, silent = true, desc = "REPL open (DAP)" })
vim.keymap.set("n", "<Leader>dl", "<CMD>lua require('dap').run_last()<CR>",
  { noremap = true, silent = true, desc = "Run last (DAP)" })
vim.fn.sign_define('DapBreakpoint',
  { text = '🟥', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointRejected',
  { text = '🟦', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped',
  { text = '⭐️', texthl = '', linehl = '', numhl = '' })


local dapuiok, dapui = pcall(require, "dapui")
if not dapuiok then
  return
end

dapui.setup({
  icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Use this to override mappings for specific elements
  element_mappings = {
    -- Example:
    -- stacks = {
    --   open = "<CR>",
    --   expand = "o",
    -- }
  },
  -- Expand lines larger than the window
  -- Requires >= 0.7
  expand_lines = vim.fn.has("nvim-0.7") == 1,
  -- Layouts define sections of the screen to place windows.
  -- The position can be "left", "right", "top" or "bottom".
  -- The size specifies the height/width depending on position. It can be an Int
  -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
  -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
  -- Elements are the elements shown in the layout (in order).
  -- Layouts are opened in order so that earlier layouts take priority in window sizing.
  layouts = {
    {
      elements = {
        -- Elements can be strings or table with id and size keys.
        { id = "scopes", size = 0.25 },
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 40, -- 40 columns
      position = "left",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
  },
  controls = {
    enabled = true,
    element = "repl",
    icons = {
      pause = "",
      play = "",
      step_into = "",
      step_over = "",
      step_out = "",
      step_back = "",
      run_last = "↻",
      terminate = "󰓛",
    },
  },
  floating = {
    max_height = nil,  -- These can be integers or a float between 0 and 1.
    max_width = nil,   -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
    max_value_lines = 100, -- Can be integer or nil.
  }
})


dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

local dapvirtualtextok, dapvirtualtext = pcall(require, "dapui")
if not dapvirtualtextok then
  return
end

dapvirtualtext.setup()
