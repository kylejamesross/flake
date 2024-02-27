local status_ok = pcall(require, "harpoon")
if not status_ok then
	return
end

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>ma", mark.add_file, { desc = "Add file"})
vim.keymap.set("n", "<leader>;", ui.toggle_quick_menu, { desc = "Toggle quick menu"})
vim.keymap.set("n", "<leader>mt", ui.toggle_quick_menu, { desc = "Toggle quick menu"})
vim.keymap.set("n", "<leader>m1", function() ui.nav_file(1) end, { desc = "Navigate to file 1"})
vim.keymap.set("n", "<leader>m2", function() ui.nav_file(2) end, { desc = "Navigate to file 2"})
vim.keymap.set("n", "<leader>m3", function() ui.nav_file(3) end, { desc = "Navigate to file 3"})
vim.keymap.set("n", "<leader>m4", function() ui.nav_file(4) end, { desc = "Navigate to file 4"})
