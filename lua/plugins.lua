local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "plugins.lua",
  command = "source <afile> | PackerSync",
})

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
    -- Load lua path
  local lua_path = function(name)
    return string.format("require'plugins.%s'", name)
  end

  ---------------------
  -- Setup Utilities --
  ---------------------

  -- Have packer manage itself
  use "wbthomason/packer.nvim"

  -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/popup.nvim"

  -- Useful lua functions used by lots of plugins
  use "nvim-lua/plenary.nvim"

  -- Dev Icons also required (for me)
  use { "kyazdani42/nvim-web-devicons", config = lua_path"nvim-web-devicons" }

  -- Easily comment stuff
  use { "numToStr/Comment.nvim", config = lua_path"comment" }

  -- File Explorer
  use { "kyazdani42/nvim-tree.lua", config = lua_path"nvim-tree" }

  -- Tabs
  use { "akinsho/bufferline.nvim", config = lua_path"bufferline" }

  -- Closing buffers
  use "moll/vim-bbye"

  -- Statusline
  use { "nvim-lualine/lualine.nvim", config = lua_path"lualine" }

  -- Floating terminals
  use { "akinsho/toggleterm.nvim", config = lua_path"toggleterm" }

  -- Project management
  use { "ahmedkhalf/project.nvim", config = lua_path"project" }

  -- Speeding up startup
  use({
    "lewis6991/impatient.nvim",
    config = function()
      local impatient = require("impatient")
      impatient.enable_profile()
    end,
  })

  -- Remove mapping escape delay
  use({
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup({
        mapping = { "jk", "kj" },
      })
    end,
  })

  -- Indentation Guides
  use {
    "lukas-reineke/indent-blankline.nvim",
    after = "nvim-treesitter",
    config = lua_path"indent-blankline"
  }

  -- Alpha Menu
  use { "goolord/alpha-nvim", config = lua_path"alpha" }

  -- This is need to fix lsp doc highlight
  use "antoinemadec/FixCursorHold.nvim"

  -- Which Key Menu
  use { "folke/which-key.nvim", config = lua_path"which-key" }

  -- For jumping cursor in every word
  use "unblevable/quick-scope"

  -- Easy motion. Crazy fast jumping cursor
  use { "phaazon/hop.nvim", config = lua_path"hop" }

  -- Multiple Select Cursor
  use "terryma/vim-multiple-cursors"

  -- Collection of minimal, independent, and fast Lua modules dedicated to improve Neovim
  -- Use for surround
  use { 'echasnovski/mini.nvim', branch = 'stable', config = lua_path"mini" }

  -- Tracking Code stats
  use "wakatime/vim-wakatime"

  -- Todo Comments
  use { "folke/todo-comments.nvim", config = lua_path"todo-comments" }

  ---------------------
  --  COLOR SCHEMES  --
  ---------------------
  -- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  use "Mofiqul/vscode.nvim"
  use "sainnhe/gruvbox-material"

  ---------------------
  -- AUTO COMPLETION --
  ---------------------
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"

  ---------------------
  --    SNIPPETS     --
  ---------------------

  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  ---------------------
  --      LSP        --
  ---------------------
  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters

  use "RRethy/vim-illuminate"

  ---------------------
  --    Telescope    --
  ---------------------

  use { "nvim-telescope/telescope.nvim", config = lua_path"telescope" }
  use "nvim-telescope/telescope-media-files.nvim"
  use "nvim-telescope/telescope-ui-select.nvim"
  use "nvim-telescope/telescope-file-browser.nvim"

  ---------------------
  --   TREESITTER    --
  ---------------------

  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", config = lua_path"nvim-treesitter" }
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use { "p00f/nvim-ts-rainbow", after = "nvim-treesitter" }
  use { "windwp/nvim-autopairs", config = lua_path"nvim-autopairs" }
  use { "windwp/nvim-ts-autotag", after = "nvim-treesitter" }

  -- code structure "breadcrumb"
  use { "SmiteshP/nvim-gps", config = lua_path"nvim-gps" }

  ---------------------
  --      GIT        --
  ---------------------

  use { "lewis6991/gitsigns.nvim", config = lua_path"gitsigns" }

  ---------------------
  --   EXPIREMENT    --
  ---------------------

  -- Plugins to Experiment in spare time
  -- use "ThePrimeagen/refactoring.nvim"
  -- use {'jdhao/better-escape.vim', event = 'InsertEnter'}
  -- use "rcarriga/nvim-notify"
  -- use "norcalli/nvim-colorizer.lua"
  -- use "nvim-pack/nvim-spectre"
  -- use "ray-x/lsp_signature.nvim"
  -- use { "michaelb/sniprun", run = "bash ./install.sh" }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
