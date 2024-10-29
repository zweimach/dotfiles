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
    hurl = 'hurl',
    hx = 'haxe',
    js = flow('javascript'),
    jsx = flow('javascriptreact'),
    re = 'reason',
    rei = 'reason',
    roc = 'roc',
  },
})
