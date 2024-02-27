local ok, dap = pcall(require, "dap")
if not ok then
  return
end

local dapuiok, dapui = pcall(require, "dapui")
if not dapuiok then
  return
end

local dapvirtualtextok, dapvirtualtext = pcall(require, "dapui")
if not dapvirtualtextok then
  return
end

dap.adapters.coreclr = {
  type = 'executable',
  command = '/etc/profiles/per-user/kyle/bin/netcoredbg',
  args = { '--interpreter=vscode' }
}

dap.configurations.cs = {
    {
      name = "Attach to process",
      type = 'coreclr',
      request = 'attach',
      processId = function()
        return vim.fn.input('Process ID: ')
      end,
    },
}

vim.keymap.set("n", "<F5>", "<CMD>lua require('dap').continue()<CR>",
  { noremap = true, silent = true, desc = "Continue" })
vim.keymap.set("n", "<F10>", "<CMD>lua require('dap').step_over()<CR>",
  { noremap = true, silent = true, desc = "Step over" })
vim.keymap.set("n", "<F11>", "<CMD>lua require('dap').step_into()<CR>",
  { noremap = true, silent = true, desc = "Step into" })
vim.keymap.set("n", "<F12>", "<CMD>lua require('dap').step_out()<CR>",
  { noremap = true, silent = true, desc = "Step out" })
vim.keymap.set("n", "<Leader>db", "<CMD>lua require('dap').toggle_breakpoint()<CR>",
  { noremap = true, silent = true, desc = "Toggle breakpoint" })
vim.keymap.set("n", "<Leader>dB",
  "<CMD>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
  { noremap = true, silent = true, desc = "Set breakpoint" })
vim.keymap.set("n", "<Leader>dr", "<CMD>lua require('dap').repl_open()<CR>",
  { noremap = true, silent = true, desc = "REPL open" })
vim.keymap.set("n", "<Leader>dl", "<CMD>lua require('dap').run_last()<CR>",
  { noremap = true, silent = true, desc = "Run last" })
vim.fn.sign_define('DapBreakpoint',
  { text = '🟥', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointRejected',
  { text = '🟦', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped',
  { text = '➡️', texthl = '', linehl = '', numhl = '' })

dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

dapvirtualtext.setup()
