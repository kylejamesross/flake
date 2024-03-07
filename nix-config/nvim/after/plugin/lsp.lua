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
local status_ok_neoDev, neoDev = pcall(require, "neodev")
if not status_ok_neoDev then
	return
end
local status_ok_typescript, typescript = pcall(require, "typescript")
if not status_ok_typescript then
	return
end

local extension_path = VSCODE_CODELLDB .. "/share/vscode/extensions/vadimcn.vscode-lldb/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
local capabilities = cmp_nvim_lsp.default_capabilities()
local servers = { "html", "cssls", "eslint", "lua_ls", "omnisharp", "astro", "nil_ls", "tsserver" }

local signs = {
	Error = "",
	Warn = "",
	Hint = "",
	Info = "",
}

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local function on_attach_global(_, bufnr)
	vim.keymap.set("n", "gh", vim.lsp.buf.hover, { buffer = bufnr, remap = false, silent = true, desc = "Hover" })
	-- vim.keymap.set("n", "gd", function() require("trouble").toggle("lsp_definitions") end, { desc = "Go to definition" })
	vim.keymap.set("n", "gd", vim.lsp.buf.definition,
		{ buffer = bufnr, remap = false, silent = true, desc = "Go to definition" })
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration,
		{ buffer = bufnr, remap = false, silent = true, desc = "Go to declaration" })
	vim.keymap.set("n", "gi", function() require("trouble").toggle("lsp_implementations") end,
		{ desc = "Go to implementation" })
	-- vim.keymap.set("n", "gi", vim.lsp.buf.implementation,
	-- 	{ buffer = bufnr, remap = false, silent = true, desc = "Go to implementations" })
	vim.keymap.set("n", "go", function() require("trouble").toggle("lsp_type_definitions") end,
		{ desc = "Go to type definition" })
	-- vim.keymap.set("n", "go", vim.lsp.buf.type_definition,
	-- 	{ buffer = bufnr, remap = false, silent = true, desc = "Go to type definition" })
	-- vim.keymap.set("n", "gr", vim.lsp.buf.references,
	-- 	{ buffer = bufnr, remap = false, silent = true, desc = "Go to references" })
	vim.keymap.set("n", "gr", function() require("trouble").toggle("lsp_references") end, { desc = "Go to references" })
	vim.keymap.set("n", "gl", vim.diagnostic.open_float,
		{ buffer = bufnr, remap = false, silent = true, desc = "Go diagnostic float" })
	vim.keymap.set("n", "<leader>lw", vim.lsp.buf.workspace_symbol,
		{ buffer = bufnr, remap = false, silent = true, desc = "Workspace symbol" })
	vim.keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action,
		{ buffer = bufnr, remap = false, silent = true, desc = "Code action" })
	vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename,
		{ buffer = bufnr, remap = false, silent = true, desc = "Rename" })
	vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help,
		{ buffer = bufnr, remap = false, silent = true, desc = "Signature help" })
	vim.keymap.set("n", "<leader>ll", vim.diagnostic.setloclist,
		{ buffer = bufnr, remap = false, silent = true, desc = "Set location list" })
	vim.keymap.set("n", "<leader>lq", vim.diagnostic.setqflist,
		{ buffer = bufnr, remap = false, silent = true, desc = "Set quickfix list" })
	vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>",
		{ buffer = bufnr, remap = false, silent = true, desc = "Next diagnostic" })
	vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>",
		{ buffer = bufnr, remap = false, silent = true, desc = "Previous diagnostic" })
	vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format({ bufnr, async = true }) end,
		{ buffer = bufnr, remap = false, silent = true, desc = "Format file" })
end

for _, lsp in ipairs(servers) do
	lspConfig[lsp].setup({
		on_attach = on_attach_global,
		capabilities = capabilities,
	})
end

neoDev.setup()

lspConfig.lua_ls.setup({
	on_attach = function(client, bufnr)
		on_attach_global(client, bufnr)
	end,
	settings = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
	capabilities = capabilities,
})

lspConfig.eslint.setup({
	on_attach = function(client, bufnr)
		vim.keymap.set(
			"n",
			"<leader>le",
			":EslintFixAll<CR>",
			{ buffer = bufnr, remap = false, silent = true, desc = "Eslint fix all" }
		)
		on_attach_global(client, bufnr)
	end,
	capabilities = capabilities,
})

lspConfig.omnisharp.setup({
	on_attach = function(client, bufnr)
		on_attach_global(client, bufnr)
	end,
	handlers = {
		["textDocument/definition"] = require("omnisharp_extended").handler,
	},
	cmd = { "/etc/profiles/per-user/kyle/bin/OmniSharp" },
	enable_editorconfig_support = true,
	enable_ms_build_load_projects_on_demand = false,
	enable_roslyn_analyzers = false,
	organize_imports_on_format = false,
	enable_import_completion = false,
	sdk_include_prereleases = true,
	analyze_open_documents_only = false,
	capabilities = capabilities,
})

-- snippets
require("luasnip/loaders/from_vscode").lazy_load({ paths = { "~/.config/nvim/snippets" } })

function PopulateQuickfixWithTypescriptErrors()
	local command_output = vim.fn.systemlist("tsc --noEmit --pretty false 2>&1 | grep '([^,]*,[^)]*)'")

	vim.fn.setqflist({}, "r")

	for _, line in ipairs(command_output) do
		local filename, lnum, col, text = line:match("(%S+)%((%d+),(%d+)%): error%s(.+)")
		if filename and lnum and col and text then
			local entry = {
				filename = filename,
				lnum = tonumber(lnum),
				col = tonumber(col),
				text = text,
			}
			vim.fn.setqflist({ entry }, "a")
		end
	end

	require("trouble").toggle("quickfix")
end

rustTools.setup({
	server = {
		on_attach = function(client, bufnr)
			vim.keymap.set(
				"n",
				"<leader>l1",
				rustTools.hover_actions.hover_actions,
				{ buffer = bufnr, desc = "Hover actions" }
			)
			vim.keymap.set(
				"n",
				"<leader>l2",
				rustTools.code_action_group.code_action_group,
				{ buffer = bufnr, desc = "Code Action Group" }
			)
			on_attach_global(client, bufnr)
		end,
		capabilities = capabilities,
	},
	dap = {
		adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
	},
})

lspConfig.tsserver.setup({
	on_attach = function(client, bufnr)
		vim.keymap.set(
			"n",
			"<leader>l1",
			typescript.actions.addMissingImports,
			{ buffer = bufnr, remap = false, silent = true, desc = "Add missing imports" }
		)
		vim.keymap.set(
			"n",
			"<leader>l2",
			typescript.actions.removeUnused,
			{ buffer = bufnr, remap = false, silent = true, desc = "Remove unused imports" }
		)
		vim.keymap.set(
			"n",
			"<leader>l3",
			function()
				local source = vim.api.nvim_buf_get_name(bufnr)
				vim.ui.input(
					{prompt = "New path: ", default = source},
					function(input)
						if input == "" or input == source or input == nil then
							return
						end
						typescript.renameFile(source, input)
					end
				)
			end,
			{ buffer = bufnr, remap = false, silent = true, desc = "File rename" }
		)
		vim.keymap.set(
			"n",
			"<Leader>l4",
			":lua PopulateQuickfixWithTypescriptErrors()<CR>",
			{ noremap = true, silent = true, desc = "Populate quickfix list with typescript errors" }
		)
		on_attach_global(client, bufnr)
	end,
	capabilities = capabilities,
	settings = {
		jsx_close_tag = {
			enable = true,
			filetypes = { "javascriptreact", "typescriptreact" },
		},
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
