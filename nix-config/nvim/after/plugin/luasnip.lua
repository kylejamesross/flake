local status_ok, ls = pcall(require, "luasnip")
if not status_ok then
  return
end

vim.keymap.set({"i", "s"}, "<C-F>", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-B>", function() ls.jump(-1) end, {silent = true})
