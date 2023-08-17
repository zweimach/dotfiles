-- vim: set sw=0 ts=2 et :

vim.api.nvim_create_user_command('Update', function()
  require('lazy').sync({ wait = true })
  vim.cmd.CocUpdate()
end, { nargs = 0 })

local function flow(default)
  return function(path, bufnr)
    local content = vim.filetype.getlines(bufnr, 1)
    if vim.filetype.matchregex(content, [[//\s*@flow]]) then
      return 'javascriptflow'
    end
    return default
  end
end

vim.filetype.add({
  extension = {
    c3 = 'c3',
    carp = 'carp',
    hurl = 'hurl',
    flow = 'javascriptflow',
    js = flow('javascript'),
    jsx = flow('javascriptreact'),
  },
})
