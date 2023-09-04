local keymap = vim.api.nvim_set_keymap
keymap("n", "<leader>f", ":Files<CR>", { noremap = true, silent = true })
keymap("n", "<leader>b", ":Buffers<CR>", { noremap = true, silent = true })
keymap("n", "<leader>l", ":Lines<CR>", { noremap = true, silent = true })
keymap("n", "<C-p>", ":GFiles<CR>", { noremap = true, silent = true })
-- keymap("n", "<leader>p", function()
--   builtin.grep_string({ search = vim.fn.input("Grep > ") })
-- end)
vim.cmd([[
    let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] }
]])
