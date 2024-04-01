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
		map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "[S]tage hunk" })
		map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "[R]eset hunk" })
		map("n", "<leader>hS", gs.stage_buffer, { desc = "[S]tage buffer" })
		map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "[U]ndo stage hunk" })
		map("n", "<leader>hR", gs.reset_buffer, { desc = "[R]eset buffer" })
		map("n", "<leader>hp", gs.preview_hunk, { desc = "[P]review hunk" })
		map("n", "<leader>hb", function()
			gs.blame_line({ full = true })
		end, { desc = "[Blame] line" })
		-- map("n", "<leader>hv", gs.toggle_current_line_blame, { desc = "Toggle current line blame" })
		map("n", "<leader>hd", gs.diffthis, { desc = "[D]iff this" })
		map("n", "<leader>hD", function()
			gs.diffthis("~")
		end, { desc = "[Diff] this file"})
		map("n", "<leader>hz", gs.toggle_deleted, { desc = "Toggle deleted"})

		-- Text object
		map({ "o", "x" }, "hi", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk"})
	end,
})
