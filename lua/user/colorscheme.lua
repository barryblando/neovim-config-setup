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
