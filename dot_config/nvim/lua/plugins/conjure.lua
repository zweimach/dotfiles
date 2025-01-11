-- vim: set sw=0 ts=2 et :

---@module 'lazy'
---@type LazySpec
return {
  'Olical/conjure',
  branch = 'main',
  lazy = true,
  ft = {
    'clojure',
    'fennel',
    'janet',
    'lisp',
    'racket',
    'scheme',
  },
  init = function()
    vim.g['conjure#filetype#scheme'] = 'conjure.client.guile.socket'
    vim.g['conjure#client#guile#socket#pipename'] = '.guile-repl.socket'
  end,
}
