require "user.impatient"
-- source a vimscript file
vim.cmd('source ~/.config/nvim/.vimrc.basic')

-- require "user.options"
-- require "user.keymaps"
require "user.plugins"
require "user.colorscheme"
require "user.cmp"
require "user.lsp"
require "user.telescope"
require "user.treesitter"
require "user.autopairs"
require "user.comment"
require "user.gitsigns"
-- require "user.nvim-tree"
-- require "user.bufferline"
require "user.lualine"
-- require "user.toggleterm"
-- require "user.project"
-- 4
require "user.indentline"
-- require "user.alpha"
-- require "user.whichkey"
require "user.autocommands"

-- require'colorizer'.setup()
-- local keymap = vim.api.nvim_set_keymap
-- keymap('n', '<Leader>f', ':Telescope find_files<CR>', { noremap = true, silent = true })
-- keymap('n', '<Leader>b', ':Telescope buffers<CR>', { noremap = true, silent = true })
-- keymap('n', '<Leader>n', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

