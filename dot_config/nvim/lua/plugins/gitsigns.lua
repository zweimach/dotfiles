-- vim: set sw=0 ts=2 et :

---@module 'lazy'
---@type LazySpec
return {
  'lewis6991/gitsigns.nvim',
  opts = {
    signcolumn = true,
    current_line_blame = true,
    current_line_blame_opts = {
      delay = 500,
    },
    update_debounce = 250,
    max_file_length = 10000,
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      local opts = { noremap = true, silent = true, buffer = bufnr }

      local function map(mode, keys, func, desc)
        if desc then
          desc = 'Git: ' .. desc
        end
        local opts_ = vim.tbl_deep_extend('force', opts, { desc = desc })
        vim.keymap.set(mode, keys, func, opts_)
      end

      map('n', '<Leader>ghi', gs.preview_hunk_inline, 'Preview [H]unk [I]nline')
      map('n', '[h', gs.prev_hunk, 'Previous [H]unk')
      map('n', ']h', gs.next_hunk, 'Next [H]unk')
    end,
  },
}
