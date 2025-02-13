-- vim: set sw=0 ts=2 et :

vim.api.nvim_create_user_command('Update', function()
  require('lazy').sync({ wait = true })
end, { nargs = 0 })

local yank_augroup = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  group = yank_augroup,
  callback = function()
    vim.highlight.on_yank({
      higroup = 'HighlightedyankRegion',
      timeout = 400,
    })
  end,
  pattern = '*',
})

local config_augrup = vim.api.nvim_create_augroup('UserConfig', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave', 'WinEnter' }, {
  group = config_augrup,
  callback = function()
    local current_mode = vim.api.nvim_get_mode()
    if vim.opt.number:get() and current_mode.mode ~= 'i' then
      vim.opt.relativenumber = true
    end
  end,
  pattern = '*',
})
vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter', 'WinLeave' }, {
  group = config_augrup,
  callback = function()
    if vim.opt.number:get() then
      vim.opt.relativenumber = false
    end
  end,
  pattern = '*',
})

local function flow(default)
  return function(_, bufnr)
    local lines = vim.api.nvim_buf_get_lines(bufnr, 1, 10, false)
    local content = table.concat(lines, '')
    if string.match(content, [[@flow]]) then
      return 'javascriptflow'
    else
      return default
    end
  end
end

vim.filetype.add({
  extension = {
    c3 = 'c3',
    carp = 'carp',
    flow = 'javascriptflow',
    fun = 'sml',
    hurl = 'hurl',
    hx = 'haxe',
    idr = 'idris',
    ipkg = 'ipkg',
    js = flow('javascript'),
    jsx = flow('javascriptreact'),
    ll = 'llvm',
    mdx = 'markdown.mdx',
    purs = 'purescript',
    re = 'reason',
    rei = 'reason',
    roc = 'roc',
    sig = 'sml',
    sld = 'scheme',
    sls = 'scheme',
  },
  filename = {
    ['rebar.config'] = 'erlang',
  },
})
