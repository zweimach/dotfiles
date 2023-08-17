-- vim: set sw=0 ts=2 et :

return {
  'neoclide/coc.nvim',
  branch = 'release',
  config = function()
    -- Use tab for trigger completion with characters ahead and navigate.
    -- NOTE: There's always complete item selected by default, you may want to enable
    -- no select by `"suggest.noselect": true` in your configuration file.
    -- NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    -- other plugin before putting this into your config.
    vim.keymap.set(
      'i',
      '<Tab>',
      'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<Tab>" : coc#refresh()',
      { noremap = true, silent = true, expr = true, replace_keycodes = false }
    )
    vim.keymap.set('i', '<S-Tab>', [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], { noremap = true, silent = true, expr = true, replace_keycodes = false })

    -- Make <CR> to accept selected completion item or notify coc.nvim to format.
    -- <C-g>u breaks current undo, please make your own choice.
    vim.keymap.set(
      'i',
      '<CR>',
      [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<C-r>=coc#on_enter()\<CR>"]],
      { noremap = true, silent = true, expr = true, replace_keycodes = false }
    )

    function _G.check_back_space()
      local col = vim.fn.col('.') - 1
      return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
    end

    -- Use <C-Space> to trigger completion.
    vim.keymap.set('i', '<C-Space>', 'coc#refresh()', { silent = true, noremap = true, expr = true })

    -- Use `[g` and `]g` to navigate diagnostics.
    -- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
    vim.keymap.set('n', '[g', '<Plug>(coc-diagnostic-prev)', { silent = true, noremap = true })
    vim.keymap.set('n', ']g', '<Plug>(coc-diagnostic-next)', { silent = true, noremap = true })

    -- GoTo code navigation.
    vim.keymap.set('n', 'gd', '<Cmd>Telescope coc definitions<CR>', { silent = true, noremap = true })
    vim.keymap.set('n', 'gD', '<Cmd>Telescope coc declarations<CR>', { silent = true, noremap = true })
    vim.keymap.set('n', 'gy', '<Cmd>Telescope coc type_definitions<CR>', { silent = true, noremap = true })
    vim.keymap.set('n', 'gi', '<Cmd>Telescope coc implementations<CR>', { silent = true, noremap = true })
    vim.keymap.set('n', 'gr', '<Cmd>Telescope coc references<CR>', { silent = true, noremap = true })

    -- Use K to show documentation in preview window.
    vim.keymap.set('n', 'K', '<Cmd>lua _G.show_documentation()<CR>', { silent = true, noremap = true })

    function _G.show_documentation()
      if vim.fn.CocAction('hasProvider', 'hover') then
        vim.fn.CocActionAsync('doHover')
      else
        vim.fn.feedkeys('K', 'in')
      end
    end

    -- Highlight the symbol and its references when holding the cursor.
    vim.api.nvim_create_augroup('CocGroup', {})
    vim.api.nvim_create_autocmd('CursorHold', {
      group = 'CocGroup',
      command = "silent call CocActionAsync('highlight')",
    })

    -- Symbol renaming.
    vim.keymap.set('n', '<Leader>rn', '<Plug>(coc-rename)', { silent = true, noremap = true })

    -- Formatting selected code.
    vim.keymap.set('x', '<Leader>f', '<Plug>(coc-format-selected)', { silent = true, noremap = true })
    vim.keymap.set('n', '<Leader>f', '<Plug>(coc-format-selected)', { silent = true, noremap = true })

    -- Update signature help on jump placeholder
    vim.api.nvim_create_autocmd('User', {
      group = 'CocGroup',
      pattern = 'CocJumpPlaceholder',
      command = "call CocActionAsync('showSignatureHelp')",
    })

    -- Apply codeAction to the selected region.
    -- Example: `<leader>aap` for current paragraph
    vim.keymap.set('x', '<Leader>a', '<Plug>(coc-codeaction-selected)', { silent = true, noremap = true, nowait = true })
    vim.keymap.set('n', '<Leader>a', '<Plug>(coc-codeaction-selected)', { silent = true, noremap = true, nowait = true })

    -- Remap keys for applying codeAction at the current cursor position.
    vim.keymap.set('n', '<Leader>ac', '<Plug>(coc-codeaction-cursor)', { silent = true, noremap = true, nowait = true })
    -- Remap keys for apply code actions affect whole buffer.
    vim.keymap.set('n', '<Leader>as', '<Plug>(coc-codeaction-source)', { silent = true, noremap = true, nowait = true })
    -- Apply AutoFix to problem on the current line.
    vim.keymap.set('n', '<Leader>qf', '<Plug>(coc-fix-current)', { silent = true, noremap = true, nowait = true })
    -- Run the Code Lens action on the current line.
    vim.keymap.set('n', '<Leader>cl', '<Plug>(coc-codelens-action)', { silent = true, noremap = true, nowait = true })

    -- Map function and class text objects
    -- NOTE: Requires 'textDocument.documentSymbol' support from the language server.
    vim.keymap.set('x', 'if', '<Plug>(coc-funcobj-i)', { silent = true, noremap = true, nowait = true })
    vim.keymap.set('o', 'if', '<Plug>(coc-funcobj-i)', { silent = true, noremap = true, nowait = true })
    vim.keymap.set('x', 'af', '<Plug>(coc-funcobj-a)', { silent = true, noremap = true, nowait = true })
    vim.keymap.set('o', 'af', '<Plug>(coc-funcobj-a)', { silent = true, noremap = true, nowait = true })
    vim.keymap.set('x', 'ic', '<Plug>(coc-classobj-i)', { silent = true, noremap = true, nowait = true })
    vim.keymap.set('o', 'ic', '<Plug>(coc-classobj-i)', { silent = true, noremap = true, nowait = true })
    vim.keymap.set('x', 'ac', '<Plug>(coc-classobj-a)', { silent = true, noremap = true, nowait = true })
    vim.keymap.set('o', 'ac', '<Plug>(coc-classobj-a)', { silent = true, noremap = true, nowait = true })

    -- Remap <C-f> and <C-b> to scroll float windows/popups.
    -- NOTE: coc#float#scroll works on neovim >= 0.4.0 or vim >= 8.2.0750.
    vim.keymap.set('n', '<C-f>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', { silent = true, nowait = true, expr = true, noremap = true })
    vim.keymap.set('n', '<C-b>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', { silent = true, nowait = true, expr = true, noremap = true })
    vim.keymap.set('i', '<C-f>', 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', { silent = true, nowait = true, expr = true, noremap = true })
    vim.keymap.set('i', '<C-b>', 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', { silent = true, nowait = true, expr = true, noremap = true })
    vim.keymap.set('v', '<C-f>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', { silent = true, nowait = true, expr = true, noremap = true })
    vim.keymap.set('v', '<C-b>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', { silent = true, nowait = true, expr = true, noremap = true })

    -- Use CTRL-S for selections ranges.
    -- Requires 'textDocument/selectionRange' support of language server.
    vim.keymap.set('n', '<C-s>', '<Plug>(coc-range-select)', { silent = true, noremap = true })
    vim.keymap.set('x', '<C-s>', '<Plug>(coc-range-select)', { silent = true, noremap = true })

    -- Add `:Format` command to format current buffer.
    vim.api.nvim_create_user_command('Format', "call CocAction('format')", { nargs = 0 })

    -- " Add `:Fold` command to fold current buffer.
    vim.api.nvim_create_user_command('Fold', "call CocAction('fold', <f-args>)", { nargs = '?' })

    -- Add `:OR` command for organize imports of the current buffer.
    vim.api.nvim_create_user_command('OR', "call CocActionAsync('runCommand', 'editor.action.organizeImport')", { nargs = 0 })

    -- Mappings for CocList and telescope-coc.nvim
    vim.keymap.set('n', '<Space>b', ':<C-u>Telescope coc diagnostics<CR>', { silent = true, noremap = true, nowait = true })
    vim.keymap.set('n', '<Space>a', ':<C-u>Telescope coc workspace_diagnostics<CR>', { silent = true, noremap = true, nowait = true })
    vim.keymap.set('n', '<Space>d', ':<C-u>Telescope coc document_symbols<CR>', { silent = true, noremap = true, nowait = true })
    vim.keymap.set('n', '<Space>s', ':<C-u>Telescope coc workspace_symbols<CR>', { silent = true, noremap = true, nowait = true })
    vim.keymap.set('n', '<Space>h', ':<C-u>Telescope coc file_code_actions<CR>', { silent = true, noremap = true, nowait = true })
    vim.keymap.set('n', '<Space>c', ':<C-u>Telescope coc commands<CR>', { silent = true, noremap = true, nowait = true })
    vim.keymap.set('n', '<Space>e', ':<C-u>CocList extensions<CR>', { silent = true, noremap = true, nowait = true })
    vim.keymap.set('n', '<Space>o', ':<C-u>CocList outline<CR>', { silent = true, noremap = true, nowait = true })
    vim.keymap.set('n', '<Space>y', ':<C-u>CocList yank<CR>', { silent = true, noremap = true, nowait = true })
    vim.keymap.set('n', '<Space>j', ':<C-u>CocNext<CR>', { silent = true, noremap = true, nowait = true })
    vim.keymap.set('n', '<Space>k', ':<C-u>CocPrev<CR>', { silent = true, noremap = true, nowait = true })
  end,
}
