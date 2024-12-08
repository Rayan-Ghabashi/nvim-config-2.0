-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  -- Rose Pine Colorscheme
  use({
    'rose-pine/neovim',
    as = 'rose-pine',
    config = function()
      vim.cmd('colorscheme rose-pine') -- Load colorscheme after the plugin is loaded
    end
  })

  -- Treesitter
  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
  use('nvim-treesitter/playground')

  -- Other utilities
  use('theprimeagen/harpoon')
  use('mbbill/undotree')
  use('tpope/vim-fugitive')

  -- Completion plugins
  use('hrsh7th/nvim-cmp')
  use('hrsh7th/cmp-nvim-lsp')         -- LSP completion source for nvim-cmp
  use('L3MON4D3/LuaSnip')            -- LuaSnip for snippet support
  use('saadparwaiz1/cmp_luasnip')    -- Snippet source for nvim-cmp
  use('hrsh7th/cmp-path')            -- Path completion
  use('hrsh7th/cmp-buffer')          -- Buffer completion
  use('hrsh7th/cmp-nvim-lua')        -- Lua-specific completion for nvim config

  -- LSP configuration
  use('neovim/nvim-lspconfig')

  -- Mason: Manage LSP servers and other tools
  use {
    'williamboman/mason.nvim', -- Mason plugin for managing LSP servers, DAP, and other tools
    run = ':MasonUpdate'       -- Optional, updates Mason registry on install
  }
  use {
    'williamboman/mason-lspconfig.nvim' -- Mason-LSP bridge for easier LSP setup
  }
  use {
	  'nvim-tree/nvim-web-devicons',
	  config = function()
		  require('nvim-web-devicons').setup {
			  default = true; -- Enable default icons globally
		  }
	  end
  }

  -- nvim-tree.lua: File explorer
  use {
  'nvim-tree/nvim-tree.lua',
  requires = {
    'nvim-tree/nvim-web-devicons', -- Required for file icons
  },
  config = function()
    require('nvim-tree').setup {
      renderer = {
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
        },
      },
    }
  end
}
use {
    'linux-cultist/venv-selector.nvim',
    branch = 'regexp', -- Ensure you specify the new branch
}end)
