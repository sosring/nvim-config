local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then 
  return 
end 

return packer.startup(function(use)
 use("wbthomason/packer.nvim")
 use("bluz71/vim-nightfly-guicolors") -- preferred colorscheme 
 use ('shaunsingh/nord.nvim') -- nord theme

 -- tmux & split window navigation
 use("christoomey/vim-tmux-navigator")
 use("szw/vim-maximizer") -- maximizes and restores current window
 use("vim-scripts/ReplaceWithRegister")
 use('mattn/emmet-vim') -- emmet
 use('preservim/nerdtree') -- nerdTree
 use('glepnir/dashboard-nvim')
 use('windwp/nvim-autopairs')
 use('nvim-tree/nvim-web-devicons') 
 use('nvim-lualine/lualine.nvim') -- status line
 use("akinsho/toggleterm.nvim") -- toggle terminal
 use( 'mhartington/formatter.nvim' ) -- formatter

 use {
   'nvim-telescope/telescope.nvim', tag = '0.1.0',
   requires = { {'nvim-lua/plenary.nvim'} }
 }

 use('rose-pine/neovim')
 use('nvim-treesitter/nvim-treesitter',{ run = ':TSUpdate'})

 use {
   'VonHeikemen/lsp-zero.nvim',
   requires = {
     -- LSP Support
     {'neovim/nvim-lspconfig'},
     {'williamboman/mason.nvim'},
     {'williamboman/mason-lspconfig.nvim'},

     -- Autocompletion
     {'hrsh7th/nvim-cmp'},
     {'hrsh7th/cmp-buffer'},
     {'hrsh7th/cmp-path'},
     {'saadparwaiz1/cmp_luasnip'},
     {'hrsh7th/cmp-nvim-lsp'},
     {'hrsh7th/cmp-nvim-lua'},

     -- Snippets
     {'L3MON4D3/LuaSnip'},
     {'rafamadriz/friendly-snippets'},
   }
 }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
