-- vim: set sw=0 ts=2 et :

return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('nvim-tree').setup({
      disable_netrw = true,
      hijack_netrw = true,
      hijack_cursor = true,
      respect_buf_cwd = true,
      update_cwd = true,
      filters = {
        custom = { '^\\.git$' },
      },
      view = {
        width = 40,
        side = 'left',
      },
      renderer = {
        add_trailing = true,
        group_empty = true,
        highlight_git = true,
        highlight_opened_files = 'name',
        icons = {
          show = {
            folder_arrow = false,
          },
        },
        indent_markers = {
          enable = true,
        },
        special_files = { 'Makefile', 'MAKEFILE', 'README.md', 'readme.md', 'LICENSE' },
      },
      actions = {
        open_file = {
          window_picker = {
            enable = false,
            exclude = {
              filetype = { 'notify', 'packer', 'qf', 'diff', 'fugitive', 'fugitiveblame' },
              buftype = { 'nofile', 'terminal', 'help' },
            },
          },
        },
      },
    })

    vim.keymap.set('n', '<C-\\>', '<Cmd>NvimTreeToggle<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<Leader>r', '<Cmd>NvimTreeRefresh<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<Leader>n', '<Cmd>NvimTreeFindFileToggle<CR>', { noremap = true, silent = true })
  end,
}
