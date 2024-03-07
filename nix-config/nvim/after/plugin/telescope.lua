local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

pcall(require('telescope').load_extension, 'ui-select')
pcall(require('telescope').load_extension, 'media_files')
pcall(require('telescope').load_extension, 'fzy_native')
pcall(require('telescope').load_extension, 'undo')

telescope.setup({
	defaults = {
		prompt_prefix = " ",
		selection_caret = " ",
		path_display = { "absolute" },
		mappings = {
			i = {
				["<C-n>"] = require("telescope.actions").cycle_history_next,
				["<C-p>"] = require("telescope.actions").cycle_history_prev,

				["<C-j>"] = require("telescope.actions").move_selection_next,
				["<C-k>"] = require("telescope.actions").move_selection_previous,

				["<C-c>"] = require("telescope.actions").close,

				["<Down>"] = require("telescope.actions").move_selection_next,
				["<Up>"] = require("telescope.actions").move_selection_previous,

				["<CR>"] = require("telescope.actions").select_default,
				["<C-x>"] = require("telescope.actions").select_horizontal,
				["<C-v>"] = require("telescope.actions").select_vertical,
				["<C-t>"] = require("telescope.actions").select_tab,

				["<C-u>"] = require("telescope.actions").preview_scrolling_up,
				["<C-d>"] = require("telescope.actions").preview_scrolling_down,

				["<PageUp>"] = require("telescope.actions").results_scrolling_up,
				["<PageDown>"] = require("telescope.actions").results_scrolling_down,

				["<Tab>"] = require("telescope.actions").toggle_selection +
					require("telescope.actions").move_selection_worse,
				["<S-Tab>"] = require("telescope.actions").toggle_selection +
					require("telescope.actions").move_selection_better,
				["<C-q>"] = require("telescope.actions").send_to_qflist + require("telescope.actions").open_qflist,
				["<M-q>"] = require("telescope.actions").send_selected_to_qflist +
					require("telescope.actions").open_qflist,
				["<C-l>"] = require("telescope.actions").complete_tag,
				["<C-_>"] = require("telescope.actions").which_key, -- keys from pressing <C-/>
			},
			n = {
				["<esc>"] = require("telescope.actions").close,
				["<CR>"] = require("telescope.actions").select_default,
				["<C-x>"] = require("telescope.actions").select_horizontal,
				["<C-v>"] = require("telescope.actions").select_vertical,
				["<C-t>"] = require("telescope.actions").select_tab,

				["<Tab>"] = require("telescope.actions").toggle_selection +
					require("telescope.actions").move_selection_worse,
				["<S-Tab>"] = require("telescope.actions").toggle_selection +
					require("telescope.actions").move_selection_better,
				["<C-q>"] = require("telescope.actions").send_to_qflist + require("telescope.actions").open_qflist,
				["<M-q>"] = require("telescope.actions").send_selected_to_qflist +
					require("telescope.actions").open_qflist,

				["j"] = require("telescope.actions").move_selection_next,
				["k"] = require("telescope.actions").move_selection_previous,
				["H"] = require("telescope.actions").move_to_top,
				["M"] = require("telescope.actions").move_to_middle,
				["L"] = require("telescope.actions").move_to_bottom,

				["<Down>"] = require("telescope.actions").move_selection_next,
				["<Up>"] = require("telescope.actions").move_selection_previous,
				["gg"] = require("telescope.actions").move_to_top,
				["G"] = require("telescope.actions").move_to_bottom,

				["<C-u>"] = require("telescope.actions").preview_scrolling_up,
				["<C-d>"] = require("telescope.actions").preview_scrolling_down,

				["<PageUp>"] = require("telescope.actions").results_scrolling_up,
				["<PageDown>"] = require("telescope.actions").results_scrolling_down,

				["?"] = require("telescope.actions").which_key,
			},
		},
	},
	extensions = {
		media_files = {
			filetypes = { "png", "webp", "jpg", "jpeg" },
			find_cmd = "rg", -- find command (defaults to `fd`)
		},
		fzy_native = {
			override_generic_sorter = false,
			override_file_sorter = true,
		},
		['ui-select'] = {
			require('telescope.themes').get_dropdown(),
		},
		undo = {
			side_by_side = true,
			layout_strategy = "vertical",
			layout_config = {
				preview_height = 0.8,
			},
		},
	},
})

local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader>su', function() telescope.extensions.undo.undo({ side_by_side = true }) end,
	{ desc = '[S]earch [U]ndo Tree' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

-- Slightly advanced example of overriding default behavior and theme
vim.keymap.set('n', '<leader>/', function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
		winblend = 10,
		previewer = false,
	})
end, { desc = '[/] Fuzzily search in current buffer' })

-- Also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
vim.keymap.set('n', '<leader>s/', function()
	builtin.live_grep {
		grep_open_files = true,
		prompt_title = 'Live Grep in Open Files',
	}
end, { desc = '[S]earch [/] in Open Files' })

-- Shortcut for searching your neovim configuration files
vim.keymap.set('n', '<leader>sn', function()
	builtin.find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[S]earch [N]eovim files' })
