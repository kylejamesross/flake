local keymap = vim.api.nvim_set_keymap

-- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- vscode mapping for file navigation
keymap("n", "<Tab>", "<C-6>", { noremap = true, silent = true, desc = "Switch to previous buffer" })

-- recenter after page up / page down / searching
keymap("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true, desc = "Move down half a page" })
keymap("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true, desc = "Move up half a page" })
keymap("n", "n", "nzzzv", { noremap = true, silent = true, desc = "Repeat search in same direction" })
keymap("n", "N", "Nzzzv", { noremap = true, silent = true, desc = "Repeat search in opposite direction" })

-- easy window movements
keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true, desc = "Go to the left window" })
keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true, desc = "Go to the bottom window" })
keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true, desc = "Go to the up window" })
keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true, desc = "Go to the right window" })

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", { noremap = true, silent = true, desc = "Increase window size vertically" })
keymap("n", "<C-Down>", ":resize -2<CR>", { noremap = true, silent = true, desc = "Descrease window size vertically" })
keymap("n", "<C-Left>", ":vertical resize +2<CR>", { noremap = true, silent = true, desc = "Increase window size horizontally" })
keymap("n", "<C-Right>", ":vertical resize -2<CR>", { noremap = true, silent = true, desc = "Decrease window size horizontally" })

-- Navigate buffers
keymap("n", "<M-l>", ":bnext<CR>", { noremap = true, silent = true, desc = "Go to next buffer" })
keymap("n", "<M-h>", ":bprevious<CR>", { noremap = true, silent = true, desc = "Go to previous buffer" })

keymap("n", "<Leader>b", ":w | %bd | e# | bd#<CR>", { noremap = true, silent = true, desc = "Delete all buffers except the active one" })
keymap("n", "<Leader>qq", ":cclose<CR>", { noremap = true, silent = true, desc = "Close quickfix list" })
keymap("n", "<Leader>qo", ":copen<CR>", { noremap = true, silent = true, desc = "Open quickfix list" })
keymap("n", "<Leader>ll", ":lclose<CR>", { noremap = true, silent = true, desc = "Close location list" })
keymap("n", "<Leader>lo", ":lopen<CR>", { noremap = true, silent = true, desc = "Open location list" })
keymap("n", "]q", ":cnext<CR>", { noremap = true, silent = true, desc = "Next quickfix list item" })
keymap("n", "[q", ":cprev<CR>", { noremap = true, silent = true, desc = "Previous quickfix list item" })
keymap("n", "]l", ":lnext<CR>", { noremap = true, silent = true, desc = "Next location list item" })
keymap("n", "[l", ":lprev<CR>", { noremap = true, silent = true, desc = "Previous location list item" })


-- paste enhancements
keymap("x", "<Leader>p", '"_dP', { noremap = false, silent = true, desc = "Paste without replacing register" })

-- move select lines up down
keymap("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move line down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move line up" })

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", { noremap = true, silent = true, desc = "Move line down" })
keymap("x", "K", ":move '<-2<CR>gv-gv", { noremap = true, silent = true, desc = "Move line up" })

-- insert mode movements
keymap("i", "<M-k>", "<Up>", { noremap = true, silent = true, desc = "Move up" })
keymap("i", "<M-j>", "<Down>", { noremap = true, silent = true, desc = "Move down" })
keymap("i", "<M-l>", "<Right>", { noremap = true, silent = true, desc = "Move right" })
keymap("i", "<M-h>", "<Left>", { noremap = true, silent = true, desc = "Move left" })

-- tab enhancements
keymap("v", "<Tab>", ">><Esc>gv", { noremap = true, silent = true, desc = "Increase Indent" })
keymap("v", "<S-Tab>", "<<<Esc>gv", { noremap = true, silent = true, desc = "Descrease Indent" })

-- editor
keymap("n", "<Leader>e", ":NvimTreeFindFileToggle<CR>", { noremap = true, silent = true, desc = "Explorer" })

-- telescope
function ProjectFiles()
  local ok = pcall(require("telescope.builtin").git_files, { show_untracked = true })
  if not ok then
    require("telescope.builtin").find_files({ hidden = true })
  end
end

keymap("n", "<c-p>", "<CMD>lua ProjectFiles()<CR>", { noremap = true, silent = true, desc = "Search for file (Telescope)" })
keymap("n", "<c-t>", "<cmd>Telescope live_grep<cr>",
  { noremap = true, silent = true, desc = "Search for string in all files (Telescope)" })
-- git
keymap("n", "<leader>vf", ":DiffviewFileHistory %<CR>", { noremap = true, silent = true, desc = "Display file history for current buffer" })
keymap("n", "<leader>vv", ":tabclose<CR>", { noremap = true, silent = true, desc = "Display file history for current buffer" })
-- refactoring  
keymap("n", "<Leader>rs", ":%s/\\<<C-r><C-w>\\>//g<Left><Left>",
  { noremap = true, silent = true, desc = "Replace all occurances of word under cursor in buffer" })
keymap("n", "<Leader>rx", ":!chmod +x %<CR>", { noremap = true, silent = true, desc = "Make file executeable" })

vim.keymap.set("n", "<leader>ma", require("harpoon.mark").add_file, { desc = "Add file"})
vim.keymap.set("n", "<leader>mt", require("harpoon.ui").toggle_quick_menu, { desc = "Toggle quick menu"})
