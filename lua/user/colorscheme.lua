vim.g.vscode_style = "dark"
vim.g.vscode_transparent = 1
vim.g.vscode_disable_nvimtree_bg = true

vim.cmd [[
try
  colorscheme vscode 
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]

-- Set bufferline bg transparent
vim.cmd [[ highlight BufferLineFill guibg=NONE ]]
-- Hide non-text from buffers i.e ~ (tilde)
vim.cmd [[ set fillchars=eob:\ ]]
-- Set statusline in nvim_tree transparent
vim.cmd [[ highlight NvimTreeStatusLineNC guibg=nvim_treebg guifg=nvim_treebg ]]
