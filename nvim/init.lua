vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set relativenumber")

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.clipboard = "unnamedplus"

-- Disable arrow keys to force hjkl usage
vim.keymap.set({'n', 'i', 'v'}, '<Up>', '<Nop>')
vim.keymap.set({'n', 'i', 'v'}, '<Down>', '<Nop>')
vim.keymap.set({'n', 'i', 'v'}, '<Left>', '<Nop>')
vim.keymap.set({'n', 'i', 'v'}, '<Right>', '<Nop>')

-- Quick save with leader+w
vim.keymap.set('n', '<leader>w', '<cmd>w<cr>', { desc = "Save file" })

-- Exit insert mode with jj
vim.keymap.set('i', 'jj', '<Esc>', { desc = "Exit insert mode" })

require("config.lazy")

