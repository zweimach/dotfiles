-- vim: set sw=0 ts=2 et :

---@module 'lazy'
---@type LazySpec
return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = function()
    local telescope = require('telescope')
    local builtin = require('telescope.builtin')

    telescope.setup({
      defaults = {
        layout_strategy = 'vertical',
        layout_config = {
          prompt_position = 'top',
          vertical = { width = 0.8 },
        },
        sorting_strategy = 'ascending',
      },
      pickers = {
        command_history = {
          theme = 'dropdown',
        },
      },
    })
    telescope.load_extension('fzf')

    local ripgrep_args = { '--hidden' }
    local grep_string = function(use_regex)
      return function(opts)
        builtin.grep_string({ search = opts.args, use_regex = use_regex, additional_args = ripgrep_args })
      end
    end

    vim.api.nvim_create_user_command('R', grep_string(false), { nargs = 1 })
    vim.api.nvim_create_user_command('Rg', grep_string(true), { nargs = 1 })

    local opts = { noremap = true, silent = true }

    vim.keymap.set('n', '<C-p>', function()
      builtin.find_files({ hidden = true })
    end, opts)
    vim.keymap.set('n', '<A-o>', function()
      builtin.buffers({ ignore_current_buffer = true })
    end, opts)
    vim.keymap.set('n', '<A-r>', builtin.live_grep, opts)
    vim.keymap.set('n', '<A-t>', builtin.grep_string, opts)
    vim.keymap.set('n', '<A-c>', builtin.command_history, opts)
    vim.keymap.set('n', '<A-h>', builtin.help_tags, opts)
    vim.keymap.set('n', '<A-m>', builtin.marks, opts)
    vim.keymap.set('n', '<A-n>', builtin.jumplist, opts)
  end,
}
