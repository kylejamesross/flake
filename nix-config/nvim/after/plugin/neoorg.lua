local status_ok, neorg = pcall(require, "neorg")
if not status_ok then
    return
end

neorg.setup {
    load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.dirman"] = {
            config = {
                workspaces = {
                    personal = "~/personal/notes",
                    work = "~/source/notes",
                },
            },
        }
    }
}
vim.keymap.set("n", "<leader>ni", "<cmd>:Neorg index<CR>", { noremap = true, silent = true, desc = "Go to index" })
vim.keymap.set("n", "<leader>nr", "<cmd>:Neorg return<CR>", { noremap = true, silent = true, desc = "Return to" })
vim.keymap.set("n", "<leader>nw", "<cmd>:Neorg workspace work<CR>",
    { noremap = true, silent = true, desc = "Go to work workspace" })
vim.keymap.set("n", "<leader>np", "<cmd>:Neorg workspace personal<CR>",
    { noremap = true, silent = true, desc = "Go to personal workspace" })
