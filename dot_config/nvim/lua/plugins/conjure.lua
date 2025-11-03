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
    'sql',
  },
  init = function()
    vim.g['conjure#client#clojure#nrepl#connection#auto_repl#enabled'] = false
    vim.g['conjure#client#guile#socket#host_port'] = 'localhost:37146'
    vim.g['conjure#filetype#scheme'] = 'conjure.client.guile.socket'
    vim.g['conjure#mapping#doc_word'] = 'gk'
    vim.g['conjure#filetypes'] = {
      'clojure',
      'fennel',
      'janet',
      'lisp',
      'racket',
      'scheme',
      'sql',
    }
  end,
}
