local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
	return
end

gitsigns.setup({
	current_line_blame = true,
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map("n", "]h", function()
			if vim.wo.diff then
				return "]h"
			end
			vim.schedule(function()
				gs.next_hunk()
			end)
			return "<Ignore>"
		end, { expr = true, desc = "Next hunk" })

		map("n", "[h", function()
			if vim.wo.diff then
				return "[h"
			end
			vim.schedule(function()
				gs.prev_hunk()
			end)
			return "<Ignore>"
		end, { expr = true, desc = "Previous hunk" })

		-- Actions
		map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "Stage hunk (HUNKS)" })
		map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk (HUNKS)" })
		map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer (HUNKS)" })
		map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk (HUNKS)" })
		map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer (HUNKS)" })
		map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk (HUNKS)" })
		map("n", "<leader>hb", function()
			gs.blame_line({ full = true })
		end, { desc = "Blame line (HUNKS)" })
		map("n", "<leader>hv", gs.toggle_current_line_blame, { desc = "Toggle current line blame (HUNKS)" })
		map("n", "<leader>hd", gs.diffthis, { desc = "Diff this (HUNKS)" })
		map("n", "<leader>hD", function()
			gs.diffthis("~")
		end, { desc = "Diff this file (HUNKS)"})
		map("n", "<leader>hz", gs.toggle_deleted, { desc = "Toggle deleted (HUNKS)"})

		-- Text object
		map({ "o", "x" }, "hi", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk (HUNKS)"})
	end,
})
