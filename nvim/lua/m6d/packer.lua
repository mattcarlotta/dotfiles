vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.1',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {
	  'Luxed/ayu-vim',
	  as = 'ayu',
	  config = function()
		  vim.cmd('colorscheme ayu')
	  end
  }

  use({
      "folke/trouble.nvim",
      config = function()
          require("trouble").setup {
              icons = false,
              -- your configuration comes here
              -- or leave it empty to use the default settings
              -- refer to the configuration section below
          }
      end
  })

  use({ 
      'lukas-reineke/indent-blankline.nvim',
      -- Enable `lukas-reineke/indent-blankline.nvim`
      -- See `:help indent_blankline.txt`
      opts = {
          char = '┊',
          show_trailing_blankline_indent = false,
      }
  })

  -- "gc" to comment visual regions/lines
  use({ 'numToStr/Comment.nvim', opts = {} })

  use {
      'lewis6991/gitsigns.nvim',
      -- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
  }

  use({"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"})
  use("theprimeagen/harpoon")
  use("mbbill/undotree")
  use("tpope/vim-fugitive")
  use("nvim-treesitter/nvim-treesitter-context");
  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v1.x',
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

  use('mhartington/formatter.nvim')

end)
