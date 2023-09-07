local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
-- print('----')
-- print(install_path)
-- print('----')
-- :echo stdpath("config")
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

-- Install your plugins here
return packer.startup(function(use)
  use("wbthomason/packer.nvim") -- Have packer manage itself

  -- Plugins START --
  use({ "junegunn/fzf", run = "fzf#install()" })
  use({ "junegunn/fzf.vim" })

  use("lambdalisue/fern.vim")
  use("lambdalisue/fern-git-status.vim")

  use({
    'rose-pine/neovim',
    as = 'rose-pine',
    config = function()
      vim.cmd('colorscheme rose-pine')
    end
  })

  use({ "nvim-treesitter/nvim-treesitter", run = ':TSUpdate' })
  -- use({ "nvim-treesitter/playground" })

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      {                          -- Optional
        'williamboman/mason.nvim',
        run = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },   -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'L3MON4D3/LuaSnip' },   -- Required
    }
  }


  use { "windwp/nvim-autopairs", commit = "4fc96c8f3df89b6d23e5092d31c866c53a346347" } -- Autopairs, integrates with both cmp and treesitter
  use {
    "numToStr/Comment.nvim",
    -- config = function()
    --   require('Comment').setup()
    -- end,
    commit = "97a188a98b5a3a6f9b1b850799ac078faa17ab67"
  }
  use { "JoosepAlviste/nvim-ts-context-commentstring", commit = "4d3a68c41a53add8804f471fcc49bb398fe8de08" }

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

  -- use("jpalardy/vim-slime")
  -- vim.cmd([[
  --   let g:slime_default_config={'socket_name': 'default', 'target_pane': '{right-of}'}
  --   let g:slime_paste_file=tempname()
  --   let g:slime_target='tmux'
  --   xmap <Leader>r <Plug>SlimeRegionSend
  --   nmap <Leader>r <Plug>SlimeParagraphSend
  --   nmap <c-c>v     <Plug>SlimeConfig
  -- ]])

  -- misc
  use("tweekmonster/startuptime.vim")
  -- use("xiyaowong/nvim-transparent") -- enable if all the same
  use("nathom/filetype.nvim")

  use('ap/vim-css-color')

  -- use { 'morhetz/gruvbox',
  --   config = function()
  --     vim.cmd [[
  --       let g:gruvbox_transparent_bg=1
  --       autocmd vimenter * colorscheme gruvbox
  --       hi Normal guibg=NONE ctermbg=NONE
  --     ]]
  --   end,
  -- }

  -- Plugins END --

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
