-- #########################
--    AUTOCOMMANDS START
-- #########################

vim.api.nvim_create_autocmd({ "User" }, {
  pattern = { "AlphaReady" },
  callback = function()
    vim.cmd [[
      set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
    ]]
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
    ]]
  end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
  end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd "set formatoptions-=cro"
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.cmd "autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif"

vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    vim.cmd "hi link illuminatedWord CursorLine"
  end,
})

-- #########################
--     AUTOCOMMANDS END
-- #########################)

-- vim.cmd [[
--   augroup _general_settings
--     autocmd!
--     autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
--     autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200})
--     autocmd BufWinEnter * :set formatoptions-=cro
--     autocmd FileType qf set nobuflisted
--   augroup end
--
--   augroup _git
--     autocmd!
--     autocmd FileType gitcommit setlocal wrap
--     autocmd FileType gitcommit setlocal spell
--   augroup end
--
--   augroup _markdown
--     autocmd!
--     autocmd FileType markdown setlocal wrap
--     autocmd FileType markdown setlocal spell
--   augroup end
--
--   augroup _json
--     autocmd!
--     autocmd BufNewFile,BufRead tsconfig.json setlocal filetype=jsonc
--     autocmd BufNewFile,BufRead tsconfig.*.json setlocal filetype=jsonc
--   augroup end
--
--   augroup _auto_resize
--     autocmd!
--     autocmd VimResized * tabdo wincmd =
--   augroup end
-- ]]

-- Autoformat
-- augroup _lsp
--   autocmd!
--   autocmd BufWritePre * lua vim.lsp.buf.formatting()
-- augroup end
