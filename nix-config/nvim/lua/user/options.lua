local options = {
	number = true,
	relativenumber = true,
	signcolumn = "auto",
	swapfile = false,
	backup = false,
	hlsearch = false,
	ignorecase = true,
	history = 1000,
	ruler = true,
	showcmd = true,
	wildmenu = true,
	scrolloff = 8,
	incsearch = true,
	expandtab = true,
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
	cmdheight = 0,
	conceallevel = 0,
	cursorline = true,
	showtabline = 1,
	splitbelow = true,
	splitright = true,
	completeopt = { "menuone", "noselect" },
	timeoutlen = 1000,
	undofile = true,
	numberwidth = 2,
	guifont = "monospace:h17",
	termguicolors = true,
	autoread = true,
	jumpoptions = 'stack'
}
-- set all options
for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.api.nvim_exec([[
	let g:fugitive_summary_format = "%cs || %<(20,trunc)%an || %s"
]], true)
