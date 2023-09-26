-- vim: set sw=0 ts=2 et :

local opts = { noremap = true, silent = true }
local map = vim.keymap.set

map('n', '<A-g>', '<Cmd>tab Git<CR>', opts)
map('n', '<C-j>', '<Cmd>bnext<CR>', opts)
map('n', '<A-j>', '<Cmd>tabnext<CR>', opts)
map('n', '<C-k>', '<Cmd>bprev<CR>', opts)
map('n', '<A-k>', '<Cmd>tabprevious<CR>', opts)
map('v', 'J', ":m '>+1<CR>gv=gv", opts)
map('v', 'K', ":m '<-2<CR>gv=gv", opts)
