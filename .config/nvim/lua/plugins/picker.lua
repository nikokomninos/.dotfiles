return {
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
      require("telescope").setup({
        pickers = {
          find_files = {
            hidden = true
          }
        }
      })
    end
  },

  {
    'https://forge.barrettruth.com/barrettruth/canola.nvim',
    config = function()
      require("oil").setup({
        view_options = { show_hidden = true },
      })
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
}
