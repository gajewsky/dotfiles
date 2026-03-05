-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local map = vim.keymap.set

-- File and text search (adapted from old config)
map("n", "<leader>f", LazyVim.pick("files"), { desc = "Find Files" })
map("n", "<leader>a", LazyVim.pick("live_grep"), { desc = "Live Grep" })
