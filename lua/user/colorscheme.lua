-- vim.opt.termguicolors = true
-- vim.g.vscode_style = "dark"
-- vim.g.vscode_transparent = 1
-- vim.g.vscode_disable_nvimtree_bg = true

-- vim.cmd [[
-- try
--   colorscheme vscode 
-- catch /^Vim\%((\a\+)\)\=:E185/
--   colorscheme default
--   set background=dark
-- endtry
-- ]]

vim.cmd [[
  " Important!! https://github.com/sainnhe/gruvbox-material/blob/master/doc/gruvbox-material.txt
  if has('termguicolors')
    set termguicolors
  endif

  " For dark version.
  set background=dark
   
  " This configuration option should be placed before `colorscheme gruvbox-material`.
  " Available values: 'hard', 'medium'(default), 'soft'
  let g:gruvbox_material_background = 'hard'

  let g:gruvbox_material_foreground = 'mix'

  let g:gruvbox_material_transparent_background = 1
  
  " For better performance
  let g:gruvbox_material_better_performance = 1

  let g:gruvbox_material_enable_italic = 1
  
  colorscheme gruvbox-material
]]

-- Set bufferline bg transparent
vim.cmd [[ highlight BufferLineFill guibg=NONE ]]
-- Hide non-text from buffers i.e ~ (tilde)
vim.cmd [[ set fillchars=eob:\ ]]
-- Set statusline in nvim_tree transparent
-- vim.cmd [[ highlight NvimTreeStatusLineNC guibg=nvim_treebg guifg=nvim_treebg ]]


vim.cmd([[
  hi StatusLine gui=NONE guibg=NonText guisp=NonText
  hi StatusLineNc gui=NONE guibg=NonText guisp=NonText
]])
