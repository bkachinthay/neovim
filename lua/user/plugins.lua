local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Install your plugins here
return packer.startup(function(use)
  use("wbthomason/packer.nvim") -- Have packer manage itself
  use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
  use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
  use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter
  use("numToStr/Comment.nvim") -- Easily comment stuff
  -- use("tpope/vim-commentary")

  -- use "moll/vim-bbye" -- Remove file from buffer
  use("nvim-lualine/lualine.nvim")
  use("lewis6991/impatient.nvim")
  use("lukas-reineke/indent-blankline.nvim")
  use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight

  -- cmp plugins
  use("hrsh7th/nvim-cmp") -- The completion plugin
  use("hrsh7th/cmp-buffer") -- buffer completions
  use("hrsh7th/cmp-path") -- path completions
  use("hrsh7th/cmp-cmdline") -- cmdline completions
  use("saadparwaiz1/cmp_luasnip") -- snippet completions
  use("hrsh7th/cmp-nvim-lsp")

  -- snippets
  use("L3MON4D3/LuaSnip") --snippet engine
  use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

  -- LSP
  use("neovim/nvim-lspconfig") -- enable LSP
  use("williamboman/nvim-lsp-installer") -- simple to use language server installer
  use("tamago324/nlsp-settings.nvim") -- language server settings defined in json for
  use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters

  use({ "junegunn/fzf", run = "fzf#install()" })
  use({
    "junegunn/fzf.vim",
    config = function()
      local keymap = vim.api.nvim_set_keymap
      keymap("n", "<Leader>f", ":Files<CR>", { noremap = true, silent = true })
      keymap("n", "<Leader>b", ":Buffers<CR>", { noremap = true, silent = true })
      keymap("n", "<Leader>l", ":Lines<CR>", { noremap = true, silent = true })
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
    end,
  })

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })
  use("JoosepAlviste/nvim-ts-context-commentstring")

  -- Git
  use("mhinz/vim-signify")
  vim.cmd([[
    let g:signify_sign_add               = '+'
    let g:signify_sign_delete            = '_'
    let g:signify_sign_delete_first_line = '‾'
    let g:signify_sign_change            = '~'
  ]])
  -- tpope

  -- use 'tpope/vim-commentary'
  use("tpope/vim-surround")
  use("tpope/vim-repeat")
  use("haya14busa/vim-asterisk")
  use("tpope/vim-obsession")

  use("tpope/vim-fugitive")
vim.cmd([[
    nmap     <Leader>g :G<CR>gg<c-n>
    nnoremap <Leader>d :Gvdiff<CR>
    " nnoremap <nowait> <Leader>dd :Gvdiff<CR>
  ]])

  use("junegunn/vim-peekaboo")

  -- Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
  use({ "mbbill/undotree", opt = true, cmd = { "UndotreeToggle" } })
  vim.cmd([[
    let g:undotree_WindowLayout = 2
    nnoremap U :UndotreeToggle<CR>
  ]])

  use("jpalardy/vim-slime")
  vim.cmd([[
    let g:slime_default_config={'socket_name': 'default', 'target_pane': '{right-of}'}
    let g:slime_paste_file=tempname()
    let g:slime_target='tmux'
    xmap <Leader>r <Plug>SlimeRegionSend
    nmap <Leader>r <Plug>SlimeParagraphSend
    nmap <c-c>v     <Plug>SlimeConfig
  ]])

  use("lambdalisue/fern.vim")
  use("lambdalisue/fern-git-status.vim")

  -- misc
  use("tweekmonster/startuptime.vim")
  -- use("xiyaowong/nvim-transparent") -- enable if all the same
  use("nathom/filetype.nvim")

  use('ap/vim-css-color')

  use("p00f/nvim-ts-rainbow")

  -- use ( "ellisonleao/gruvbox.nvim" )
  use { 'morhetz/gruvbox',
    config = function()
      vim.cmd [[
        let g:gruvbox_transparent_bg=1
        autocmd vimenter * colorscheme gruvbox
        hi Normal guibg=NONE ctermbg=NONE
      ]]
    end,
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
