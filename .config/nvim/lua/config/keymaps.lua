-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- Go to beginning / end of line in normal mode
map("n", "gl", "g_", { noremap = true, silent = true })
map("v", "gl", "g_", { noremap = true, silent = true })
map("o", "gl", "g_", { noremap = true, silent = true })

map("n", "gh", "^", { noremap = true, silent = true })
map("v", "gh", "^", { noremap = true, silent = true })
map("o", "gh", "^", { noremap = true, silent = true })

map("n", "<leader>wv", ":vsp<CR>", { noremap = true, silent = true, desc = "Split Window Right" })
map("n", "<leader>ws", ":sp<CR>", { noremap = true, silent = true, desc = "Split Window Below" })
map("n", "<leader>wD", ":only<CR>", { noremap = true, silent = true, desc = "Close All Windows" })
map("n", "<leader>w=", "<C-w>=", { noremap = true, silent = true, desc = "Resize Windows" })

-- Sane window resizing
map("n", "<Left>", "<CMD>vertical resize +2<CR>", { noremap = true, silent = true })
map("n", "<Right>", "<CMD>vertical resize -2<CR>", { noremap = true, silent = true })
map("n", "<Up>", "<CMD>resize +2<CR>", { noremap = true, silent = true })
map("n", "<Down>", "<CMD>resize -2<CR>", { noremap = true, silent = true })

-- Go forward/backward character in insert mode
map("i", "<C-f>", "<Right>", { noremap = true, silent = true })
map("i", "<C-b>", "<Left>", { noremap = true, silent = true })

-- Luasnip Choice Node
map("i", "<C-j>", "<Plug>luasnip-next-choice", { noremap = false })
map("s", "<C-j>", "<Plug>luasnip-next-choice", { noremap = false })
map("i", "<C-k>", "<Plug>luasnip-prev-choice", { noremap = false })
map("s", "<C-k>", "<Plug>luasnip-prev-choice", { noremap = false })

-- Add line mapping
map(
  "n",
  "]<space>",
  ':<C-u>put =repeat(nr2char(10),v:count)<Bar>execute "\'[-1"<CR>',
  { noremap = true, silent = true }
)
map("n", "]o", ':<C-u>put =repeat(nr2char(10),v:count)<Bar>execute "\'[-1"<CR>', { noremap = true, silent = true })

map(
  "n",
  "[<space>",
  ':<C-u>put!=repeat(nr2char(10),v:count)<Bar>execute "\']+1"<CR>',
  { noremap = true, silent = true }
)
map("n", "[o", ':<C-u>put!=repeat(nr2char(10),v:count)<Bar>execute "\']+1"<CR>', { noremap = true, silent = true })

-- Reload Luasnip snippets
map("n", "<leader>rs", function()
  require("luasnip.loaders.from_lua").load({ paths = { vim.fn.stdpath("config") .. "/lua/snippets/" } })
  vim.notify("󰑓 LuaSnip snippets reloaded!", vim.log.levels.INFO)
end, { noremap = true, desc = "󰑓 Reload LuaSnip" })
