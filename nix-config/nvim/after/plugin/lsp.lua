local status_ok_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok_cmp_nvim_lsp then
  return
end
local status_ok_lspConfig, lspConfig = pcall(require, "lspconfig")
if not status_ok_lspConfig then
  return
end
local status_ok_rustTools, rustTools = pcall(require, "rust-tools")
if not status_ok_rustTools then
  return
end
local VSCODE_CODELLDB = os.getenv("VSCODE_CODELLDB")
if VSCODE_CODELLDB == nil then
  return
end

local extension_path = VSCODE_CODELLDB .. "/share/vscode/extensions/vadimcn.vscode-lldb/"
local codelldb_path  = extension_path .. 'adapter/codelldb'
local liblldb_path   = extension_path .. 'lldb/lib/liblldb.so'
local capabilities   = cmp_nvim_lsp.default_capabilities()
local servers        = { 'html', 'cssls', 'eslint', 'tsserver', 'lua_ls', 'omnisharp' };

local signs          = {
  Error = "",
  Warn = "",
  Hint = "",
  Info = "",
};

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local function on_attach_global(_, bufnr)
  vim.keymap.set("n", "gh", vim.lsp.buf.hover, { buffer = bufnr, remap = false, silent = true, desc = "Hover (LSP)" })
  vim.keymap.set("n", "gd", vim.lsp.buf.definition,
    { buffer = bufnr, remap = false, silent = true, desc = "Go to definition (LSP)" })
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration,
    { buffer = bufnr, remap = false, silent = true, desc = "Go to declaration (LSP)" })
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation,
    { buffer = bufnr, remap = false, silent = true, desc = "Go to implementations (LSP)" })
  vim.keymap.set("n", "go", vim.lsp.buf.type_definition,
    { buffer = bufnr, remap = false, silent = true, desc = "Go to type definition (LSP)" })
  vim.keymap.set("n", "gr", vim.lsp.buf.references,
    { buffer = bufnr, remap = false, silent = true, desc = "Go to references (LSP)" })
  vim.keymap.set("n", "gl", vim.diagnostic.open_float,
    { buffer = bufnr, remap = false, silent = true, desc = "Go diagnostic float (LSP)" })
  vim.keymap.set("n", "<leader>lw", vim.lsp.buf.workspace_symbol,
    { buffer = bufnr, remap = false, silent = true, desc = "Workspace symbol (LSP)" })
  vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action,
    { buffer = bufnr, remap = false, silent = true, desc = "Code action" })
  vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename,
    { buffer = bufnr, remap = false, silent = true, desc = "Rename (LSP)" })
  vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help,
    { buffer = bufnr, remap = false, silent = true, desc = "Signature help (LSP)" })
  vim.keymap.set("n", "<leader>ll", vim.diagnostic.setloclist,
    { buffer = bufnr, remap = false, silent = true, desc = "Set location list (LSP)" })
  vim.keymap.set("n", "<leader>lq", vim.diagnostic.setqflist,
    { buffer = bufnr, remap = false, silent = true, desc = "Set quickfix list (LSP)" })
  vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>",
    { buffer = bufnr, remap = false, silent = true, desc = "Next diagnostic (LSP)" })
  vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>",
    { buffer = bufnr, remap = false, silent = true, desc = "Previous diagnostic (LSP)" })
  vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format({ bufnr, async = true }) end,
    { buffer = bufnr, remap = false, silent = true, desc = "Format file (LSP)" })
end

for _, lsp in ipairs(servers) do
  lspConfig[lsp].setup {
    on_attach = on_attach_global,
    capabilities = capabilities,
  }
end

lspConfig.lua_ls.setup({
  on_attach = function(client, bufnr)
    on_attach_global(client, bufnr)
  end,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
  capabilities = capabilities,
})

lspConfig.eslint.setup({
  on_attach = function(client, bufnr)
    vim.keymap.set("n", "<leader>le", ":EslintFixAll<CR>",
      { buffer = bufnr, remap = false, silent = true, desc = "Eslint fix all" })
    on_attach_global(client, bufnr)
  end,
  capabilities = capabilities,
})

lspConfig.omnisharp.setup({
  on_init = function(client)
    client.server_capabilities.semanticTokensProvider = nil
  end,
  on_attach = function(client, bufnr)
    on_attach_global(client, bufnr)
  end,
  handlers = {
    ["textDocument/definition"] = require('omnisharp_extended').handler,
  },
  cmd = { "/etc/profiles/per-user/kyle/bin/OmniSharp" },
  enable_editorconfig_support = true,
  enable_ms_build_load_projects_on_demand = false,
  enable_roslyn_analyzers = true,
  organize_imports_on_format = false,
  enable_import_completion = false,
  sdk_include_prereleases = true,
  analyze_open_documents_only = true,
  capabilities = capabilities,
})

-- snippets
require("luasnip/loaders/from_vscode").lazy_load({ paths = { "~/.config/nvim/snippets" } })

function PopulateQuickfixWithTypescriptErrors()
  local command_output = vim.fn.systemlist("tsc --noEmit --pretty false 2>&1 | grep '([^,]*,[^)]*)'")

  vim.fn.setqflist({}, 'r')

  for _, line in ipairs(command_output) do
    local filename, lnum, col, text = line:match('(%S+)%((%d+),(%d+)%): error%s(.+)')
    if filename and lnum and col and text then
      local entry = {
        filename = filename,
        lnum = tonumber(lnum),
        col = tonumber(col),
        text = text,
      }
      vim.fn.setqflist({ entry }, 'a')
    end
  end

  vim.cmd('copen')
end

-- Extra typescript support
lspConfig.tsserver.setup({
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, "TypescriptRemoveUnused", function(opts)
      local typescript_status_ok, typescript = pcall(require, "typescript")
      if typescript_status_ok then
        typescript.actions.removeUnused({ sync = opts.bang, bufnr = bufnr })
      end
    end, { bang = true })
    vim.api.nvim_buf_create_user_command(bufnr, "TypescriptAddMissingImports", function(opts)
      local typescript_status_ok, typescript = pcall(require, "typescript")
      if typescript_status_ok then
        typescript.actions.addMissingImports({ sync = opts.bang, bufnr = bufnr })
      end
    end, { bang = true })
    vim.api.nvim_buf_create_user_command(bufnr, "TypescriptRenameFile", function(opts)
      local source = vim.api.nvim_buf_get_name(bufnr)
      vim.ui.input({ prompt = "New path: ", default = source }, function(input)
        if input == "" or input == source or input == nil then
          return
        end

        local typescript_status_ok, typescript = pcall(require, "typescript")
        if typescript_status_ok then
          typescript.renameFile(source, input, { force = opts.bang })
        end
      end)
    end, { bang = true })

    vim.keymap.set("n", "<leader>l1", ":TypescriptAddMissingImports<CR>",
      { buffer = bufnr, remap = false, silent = true, desc = "Add missing imports (LSP)" })
    vim.keymap.set("n", "<leader>l2", ":TypescriptRemoveUnused<CR>",
      { buffer = bufnr, remap = false, silent = true, desc = "Remove unused imports (LSP)" })
    vim.keymap.set("n", "<leader>l3", ":TypescriptRenameFile<CR>",
      { buffer = bufnr, remap = false, silent = true, desc = "File rename (LSP)" })
    vim.keymap.set("n", "<Leader>lq", ':lua PopulateQuickfixWithTypescriptErrors()<CR>',
      { noremap = true, silent = true, desc = "Populate quickfix list with typescript errors (LSP)" })
    on_attach_global(client, bufnr)
  end,
})

rustTools.setup({
  server = {
    on_attach = function(client, bufnr)
      vim.keymap.set("n", "<leader>l1", rustTools.hover_actions.hover_actions,
        { buffer = bufnr, desc = "Hover actions (LSP)" })
      vim.keymap.set("n", "<leader>l2", rustTools.code_action_group.code_action_group,
        { buffer = bufnr, desc = "Code Action Group (LSP)" })
      on_attach_global(client, bufnr)
    end,
    capabilities = capabilities,
    tools = {
      hover_actions = {
        auto_focus = true,
      },
    },
  },
  dap = {
    adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path),
  },
})

-- show diagnostic messages inline
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = false,
  float = true,
})
