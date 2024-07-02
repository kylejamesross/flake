local options = {
	number = true,
	relativenumber = true,
	signcolumn = "yes",
	swapfile = false,
	backup = false,
	breakindent = true,
	hlsearch = true,
	ignorecase = true,
	history = 1000,
	ruler = true,
	showcmd = true,
	wildmenu = true,
	scrolloff = 8,
	incsearch = true,
	expandtab = true,
    spell = true,
	wrap = true,
	shiftwidth = 4,
	tabstop = 4,
	softtabstop = 4,
	hidden = true,
	autoindent = true,
	smartindent = true,
	updatetime = 50,
	fileencoding = "UTF-8",
	undodir = os.getenv("HOME") .. "/.vim/undodir",
	clipboard = "unnamedplus",
	cmdheight = 1,
	conceallevel = 0,
	cursorline = true,
	showtabline = 1,
	splitbelow = true,
	splitright = true,
	completeopt = { "menuone", "noselect" },
	timeoutlen = 300,
	undofile = true,
	numberwidth = 2,
	guifont = "monospace:h17",
	termguicolors = true,
	autoread = true,
	virtualedit = 'block',
	jumpoptions = 'stack',
	list = true,
	listchars = { tab = '» ', trail = '·', nbsp = '␣' },
    inccommand = 'split',
}
-- set all options
for k, v in pairs(options) do
	vim.opt[k] = v
end

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  group = highlight_group,
  callback = function()
    vim.highlight.on_yank()
  end,
})
