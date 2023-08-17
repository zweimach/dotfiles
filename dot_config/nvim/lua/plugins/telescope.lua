-- vim: set sw=0 ts=2 et :

return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'fannheyward/telescope-coc.nvim',
  },
  config = function()
    local telescope = require('telescope')

    telescope.setup({
      defaults = {
        layout_config = {
          prompt_position = 'top',
        },
        sorting_strategy = 'ascending',
      },
      pickers = {
        command_history = {
          theme = 'dropdown',
        },
        find_files = {
          theme = 'dropdown',
        },
      },
    })

    telescope.load_extension('fzf')
    telescope.load_extension('coc')

    local builtin = require('telescope.builtin')
    local grep_string = function(use_regex)
      return function(opts)
        builtin.grep_string({ search = opts.args, use_regex = use_regex })
      end
    end

    vim.api.nvim_create_user_command('R', grep_string(false), { nargs = 1 })
    vim.api.nvim_create_user_command('Rg', grep_string(true), { nargs = 1 })

    vim.keymap.set('n', '<C-p>', function()
      builtin.find_files({ hidden = true })
    end, { noremap = true, silent = true })
    vim.keymap.set('n', '<A-o>', function()
      builtin.buffers({ ignore_current_buffer = true })
    end, { noremap = true, silent = true })
    vim.keymap.set('n', '<A-r>', builtin.live_grep, { noremap = true, silent = true })
    vim.keymap.set('n', '<A-t>', builtin.grep_string, { noremap = true, silent = true })
    vim.keymap.set('n', '<A-h>', builtin.command_history, { noremap = true, silent = true })
    vim.keymap.set('n', '<A-m>', builtin.marks, { noremap = true, silent = true })
    vim.keymap.set('n', '<A-n>', builtin.jumplist, { noremap = true, silent = true })
  end,
}
