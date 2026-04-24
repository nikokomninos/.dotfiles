return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = {
          registries = {
            "github:mason-org/mason-registry",
            "github:Crashdummyy/mason-registry",
          },
        }
      },
      "neovim/nvim-lspconfig",
    },
  },

  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = "main",
    build = ':TSUpdate',
    opts = {
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    },
  },

  { "nvim-treesitter/nvim-treesitter-context" },

  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
  },

  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        html = { "biome", "prettier" },
        css = { "biome" },
        javascript = { "biome", stop_after_first = true },
        javascriptreact = { "biome", stop_after_first = true },
        typescript = { "biome", stop_after_first = true },
        typescriptreact = { "biome", stop_after_first = true },
        astro = { "prettier", stop_after_first = true },
        python = { "ruff", stop_after_first = true },
        go = { "gopls", stop_after_first = true },
      },
    },
  },
}
