vim.cmd [[
try
  colorscheme tokyonight
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]

-- vim.cmd [[
-- "  let g:gruvbox_transparent_bg=1
--   autocmd vimenter * colorscheme gruvbox
--   hi Normal guibg=NONE ctermbg=NONE
-- ]]
