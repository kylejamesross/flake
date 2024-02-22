local status_ok, trouble = pcall(require, "trouble")
if not status_ok then
	return
end

trouble.setup();

vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end, { desc = "Toggle" })
vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end, { desc = "Toggle Workspace" })
vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end, { desc = "Document Diagnostics" })
vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end, { desc = "Quickfix list" })
vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end, { desc = "Local list" })
