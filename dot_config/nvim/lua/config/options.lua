-- vim: set sw=0 ts=2 et :

vim.opt.termguicolors = true
vim.opt.wrap = false
vim.opt.ruler = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.hidden = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'
vim.opt.list = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.cmdheight = 1
vim.opt.updatetime = 300
vim.opt.mouse = 'a'
vim.opt.mousemodel = 'extend'
vim.opt.signcolumn = 'yes'
vim.opt.shortmess:append('c')
vim.opt.clipboard:append('unnamedplus')
vim.opt.completeopt:append('menu')
vim.opt.completeopt:append('menuone')
vim.opt.completeopt:append('noselect')
vim.opt.formatoptions:remove('t')
vim.opt.formatoptions:remove('c')
vim.opt.scrolloff = 8
vim.opt.undofile = true
vim.opt.showmode = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.listchars = {
  conceal = '※',
  extends = '»',
  lead = '·',
  precedes = '«',
  space = '␣',
  tab = '› ',
  trail = '~',
}

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
