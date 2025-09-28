local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.clipboard = "unnamedplus"
vim.o.signcolumn = "yes"
vim.o.undofile = true
vim.o.wrap = false
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.cindent = true
vim.o.winborder = "rounded"
vim.o.mouse = 'a'
vim.o.breakindent = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true

vim.diagnostic.config({
  virtual_text = {
    spacing = 2,
  },
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

require("lazy").setup({
  spec = {
    {
      "vague2k/vague.nvim",
      lazy = false,    -- make sure we load this during startup if it is your main colorscheme
      priority = 1000, -- make sure to load this before all the other plugins
      config = function()
        -- NOTE: you do not need to call setup if you don't want to.
        require("vague").setup({
          -- optional configuration here
        })
        vim.cmd("colorscheme vague")
      end
    },

    { 'NMAC427/guess-indent.nvim' },

    { "nvim/nvim-lspconfig" },

    { "nvim-tree/nvim-web-devicons", opts = {} },

    { "lewis6991/gitsigns.nvim" },

    {
      "mason-org/mason-lspconfig.nvim",
      opts = {},
      dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
      },
    },

    {
      "nvim-treesitter/nvim-treesitter",
      branch = 'master',
      lazy = false,
      build = ":TSUpdate",
      opts = {
        ensure_installed = { "lua", "typescript", "html", "c", "cpp", "java" },
        auto_install = true,
        highlight = { enable = true, },
      },
    },

    {
      'windwp/nvim-autopairs',
      event = "InsertEnter",
      config = true
      -- use opts = {} for passing setup options
      -- this is equivalent to setup({}) function
    },

    {
      'nvim-telescope/telescope.nvim',
      tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },

    {
      'stevearc/oil.nvim',
      ---@module 'oil'
      ---@type oil.SetupOpts
      opts = {
        view_options = { show_hidden = true },
      },
      -- Optional dependencies
      dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
      -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
      lazy = false,
    },

    {
      'saghen/blink.cmp',
      -- optional: provides snippets for the snippet source
      dependencies = { 'rafamadriz/friendly-snippets' },

      -- use a release tag to download pre-built binaries
      version = '1.*',
      -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
      -- build = 'cargo build --release',
      -- If you use nix, you can build from source using latest nightly rust with:
      -- build = 'nix run .#build-plugin',

      ---@module 'blink.cmp'
      ---@type blink.cmp.Config
      opts = {
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
        -- 'super-tab' for mappings similar to vscode (tab to accept)
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- All presets have the following mappings:
        -- C-space: Open menu or open docs if already open
        -- C-n/C-p or Up/Down: Select next/previous item
        -- C-e: Hide menu
        -- C-k: Toggle signature help (if signature.enabled = true)
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        keymap = { preset = 'enter' },

        appearance = {
          -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
          -- Adjusts spacing to ensure icons are aligned
          nerd_font_variant = 'mono'
        },

        -- (Default) Only show the documentation popup when manually triggered
        completion = { documentation = { auto_show = true } },

        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
          default = { 'lsp', 'path', 'snippets', 'buffer' },
        },

        -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
        -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
        -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
        --
        -- See the fuzzy documentation for more information
        fuzzy = { implementation = "prefer_rust_with_warning" }
      },
      opts_extend = { "sources.default" }
    },

    {
      "L3MON4D3/LuaSnip",
      -- follow latest release.
      version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      -- install jsregexp (optional!).
      build = "make install_jsregexp"
    },

    {
      "NeogitOrg/neogit",
      dependencies = {
        "nvim-lua/plenary.nvim",  -- required
        "sindrets/diffview.nvim", -- optional - Diff integration

        -- Only one of these is needed.
        "nvim-telescope/telescope.nvim", -- optional
      },
    },

    -- {
    --   "pmizio/typescript-tools.nvim",
    --   dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    --   opts = {},
    -- },

    {
      "folke/trouble.nvim",
      opts = {}, -- for default options, refer to the configuration section for custom setup.
      cmd = "Trouble",
    },

    -- {
    --   "nvim-neotest/neotest",
    --   dependencies = {
    --     "nvim-neotest/nvim-nio",
    --     "nvim-lua/plenary.nvim",
    --     "antoinemadec/FixCursorHold.nvim",
    --     "nvim-treesitter/nvim-treesitter",
    --     "rcasia/neotest-java",
    --   },
    --   config = function()
    --     require("neotest").setup({
    --       adapters = {
    --         require("neotest-java"),
    --       },
    --     })
    --   end,
    -- },

    -- {
    --   "rcasia/neotest-java",
    --   ft = "java",
    --   dependencies = {
    --     "mfussenegger/nvim-jdtls",
    --     "mfussenegger/nvim-dap",           -- for the debugger
    --     "rcarriga/nvim-dap-ui",            -- recommended
    --     "theHamsta/nvim-dap-virtual-text", -- recommended
    --   },
    -- },

    -- { "jay-babu/mason-nvim-dap.nvim" },

    {
      'chomosuke/typst-preview.nvim',
      lazy = false, -- or ft = 'typst'
      version = '1.*',
      opts = {
        -- open_cmd = '/Applications/Zen.app/Contents/MacOS/zen --new-window',
        invert_colors = '{"rest": "always", "image": "never"}'
      }, -- lazy.nvim will implicitly calls `setup {}`
    },

    {
      'nvim-orgmode/orgmode',
      event = 'VeryLazy',
      ft = { 'org' },
      config = function()
        -- Setup orgmode
        require('orgmode').setup({
          org_agenda_files = '~/orgfiles/**/*',
          org_default_notes_file = '~/orgfiles/refile.org',
        })

        -- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
        -- add ~org~ to ignore_install
        -- require('nvim-treesitter.configs').setup({
        --   ensure_installed = 'all',
        --   ignore_install = { 'org' },
        -- })
      end,
    },

    {
      'MeanderingProgrammer/render-markdown.nvim',
      dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
      -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' }, -- if you use standalone mini plugins
      -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
      ---@module 'render-markdown'
      ---@type render.md.UserConfig
      opts = {},
    },

    {
      "iamcco/markdown-preview.nvim",
      cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
      build = "cd app && npm install",
      init = function()
        vim.g.mkdp_filetypes = { "markdown" }
        -- vim.cmd(
        --   [[
        -- function MarkdownPreviewNewWindow(url)
        --   execute "silent ! /Applications/Zen.app/Contents/MacOS/zen --new-window " . a:url
        -- endfunction
        -- ]]
        -- )
        -- vim.g.mkdp_browserfunc = 'MarkdownPreviewNewWindow'
      end,
      ft = { "markdown" },
      opts = {
      }
    },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "vague" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
vim.keymap.set('n', 'gs', ":Telescope lsp_document_symbols<CR>")
vim.keymap.set('n', 'gS', ":Telescope lsp_dynamic_workspace_symbols<CR>")

vim.keymap.set('n', '<leader>bb', ":Telescope buffers<CR>")
vim.keymap.set('n', '<leader>bk', ':bd<CR>')

vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename)
vim.keymap.set('n', "<leader>cs", ":Trouble symbols toggle focus=false<CR>")
vim.keymap.set('n', "<leader>cl", ":Trouble lsp toggle focus=false win.position=right<CR>")

vim.keymap.set('n', '<leader>ff', ":Telescope find_files<CR>")
vim.keymap.set('n', '<leader>fo', ":Oil<CR>")
vim.keymap.set('n', '<leader>fp', ':e ~/.config/nvim/init.lua<CR>')

vim.keymap.set('n', '<leader>hk', ":Telescope keymaps<CR>")

vim.keymap.set('n', '<leader>lb', ":set tw=80<CR>:set fo+=t<CR>")

vim.keymap.set('n', '<leader>gg', ':Neogit<CR>')

vim.keymap.set('n', '<leader>ss', ":Telescope live_grep<CR>")

-- vim.keymap.set('n', "<leader>td", ":lua require('neotest').run.run({strategy = 'dap'})<CR>")
-- vim.keymap.set('n', "<leader>tf", ":lua require('neotest').run.run(vim.fn.expand('%'))<CR>")
-- vim.keymap.set('n', "<leader>tr", ":lua require('neotest').run.run()<CR>")
-- vim.keymap.set('n', "<leader>ts", ":lua require('neotest').run.stop()<CR>")

vim.keymap.set('n', "<leader>xx", ":Trouble diagnostics toggle<CR>")
vim.keymap.set('n', "<leader>xX", ":Trouble diagnostics toggle filter.buf=0<CR>")
vim.keymap.set('n', "<leader>xL", ":Trouble loclist toggle<CR>")
vim.keymap.set('n', "<leader>xQ", ":Trouble qflist toggle<CR>")
