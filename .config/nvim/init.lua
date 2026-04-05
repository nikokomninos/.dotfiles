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
-- vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true

vim.diagnostic.config({
  virtual_text = {
    spacing = 2,
  },
})

-- vim.diagnostic.config({ virtual_text = false })

vim.lsp.config("emmylua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" } }
    }
  }
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
      "nvim-treesitter/nvim-treesitter",
      branch = 'master',
      lazy = false,
      build = ":TSUpdate",
      opts = {
        ensure_installed = { "lua", "typescript", "html", "c", "cpp", "java", "go", "typst" },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        ignore_install = { "org" },
      },
      config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
      end,
    },

    { "nvim-treesitter/nvim-treesitter-context" },

    {
      'windwp/nvim-autopairs',
      event = "InsertEnter",
      config = function()
        local npairs = require("nvim-autopairs")
        local Rule = require("nvim-autopairs.rule")

        npairs.setup({})

        npairs.add_rule(
          Rule("$", "$", "typst"),
          Rule("*", "*", "typst"),
          Rule("_", "_", "typst")
        )
      end
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

    -- {
    --   "NeogitOrg/neogit",
    --   dependencies = {
    --     "nvim-lua/plenary.nvim",  -- required
    --     "sindrets/diffview.nvim", -- optional - Diff integration

    --     -- Only one of these is needed.
    --     "nvim-telescope/telescope.nvim", -- optional
    --   },
    -- },

    -- {
    --   "pmizio/typescript-tools.nvim",
    --   dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    --   opts = {
    --     settings = {
    --       tsserver_plugins = {
    --         "@vue/typescript-plugin",
    --       },
    --     },
    --   },
    -- },

    {
      "folke/trouble.nvim",
      opts = {}, -- for default options, refer to the configuration section for custom setup.
      cmd = "Trouble",
    },

    {
      "nvim-neotest/neotest",
      dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "rcasia/neotest-java",
      },
      config = function()
        require("neotest").setup({
          adapters = {
            require("neotest-java"),
          },
        })
      end,
    },

    {
      "rcasia/neotest-java",
      ft = "java",
      dependencies = {
        "mfussenegger/nvim-jdtls",
        "mfussenegger/nvim-dap",           -- for the debugger
        "rcarriga/nvim-dap-ui",            -- recommended
        "theHamsta/nvim-dap-virtual-text", -- recommended
      },
    },

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

    -- {
    --   'nvim-orgmode/orgmode',
    --   event = 'VeryLazy',
    --   ft = { 'org' },
    --   config = function()
    --     -- Setup orgmode
    --     require('orgmode').setup({
    --       org_agenda_files = '~/orgfiles/**/*',
    --       org_default_notes_file = '~/orgfiles/refile.org',
    --       org_hide_emphasis_markers = true,
    --       org_highlight_latex_and_related = "native"
    --     })

    --     -- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
    --     -- add ~org~ to ignore_install
    --     -- require('nvim-treesitter.configs').setup({
    --     --   ensure_installed = 'all',
    --     --   ignore_install = { 'org' },
    --     -- })
    --   end,
    -- },

    -- {
    --   'MeanderingProgrammer/render-markdown.nvim',
    --   dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
    --   -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' }, -- if you use standalone mini plugins
    --   -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    --   ---@module 'render-markdown'
    --   ---@type render.md.UserConfig
    --   opts = {},
    -- },

    --{
    --  "iamcco/markdown-preview.nvim",
    --  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    --  build = "cd app && npm install",
    --  config = function()
    --    vim.g.mkdp_filetypes = { "markdown" }
    --    -- vim.cmd(
    --    --   [[
    --    -- function MarkdownPreviewNewWindow(url)
    --    --   execute "silent ! /Applications/Zen.app/Contents/MacOS/zen --new-window " . a:url
    --    -- endfunction
    --    -- ]]
    --    -- )
    --    -- vim.g.mkdp_browserfunc = 'MarkdownPreviewNewWindow'
    --  end,
    --  ft = { "markdown" },
    --  opts = {
    --  }
    --},

    -- nvim v0.8.0
    {
      "kdheepak/lazygit.nvim",
      lazy = true,
      cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
      },
      -- optional for floating window border decoration
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      -- setting the keybinding for LazyGit with 'keys' is recommended in
      -- order to load the plugin when the command is run for the first time
    },

    {
      "mfussenegger/nvim-dap",
      lazy = true,
      config = function()
        local dap = require("dap")
      end
      -- Copied from LazyVim/lua/lazyvim/plugins/extras/dap/core.lua and
      -- modified.
    },

    {
      "rcarriga/nvim-dap-ui",
      config = true,
      dependencies = {
        "jay-babu/mason-nvim-dap.nvim",
        "nvim-neotest/nvim-nio",
        "theHamsta/nvim-dap-virtual-text",
      },
    },

    {
      "ellisonleao/carbon-now.nvim",
      lazy = true,
      cmd = "CarbonNow",
      ---@param opts cn.ConfigSchema
      opts = { [[ your custom config here ]] }
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

    {
      'norcalli/nvim-colorizer.lua',
    },

    {
      'barrett-ruth/live-server.nvim',
      build = 'pnpm add -g live-server',
      cmd = { 'LiveServerStart', 'LiveServerStop' },
      config = true
    },

    { 'sindrets/diffview.nvim' },

    {
      "ray-x/go.nvim",
      dependencies = { -- optional packages
        "ray-x/guihua.lua",
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
      },
      opts = function()
        require("go").setup(opts)
        local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
        vim.api.nvim_create_autocmd("BufWritePre", {
          pattern = "*.go",
          callback = function()
            require('go.format').goimports()
          end,
          group = format_sync_grp,
        })
        return {
          -- lsp_keymaps = false,
          -- other options
        }
      end,
      event = { "CmdlineEnter" },
      ft = { "go", 'gomod' },
      build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
    },

    {
      "seblyng/roslyn.nvim",
      ---@module 'roslyn.config'
      ---@type RoslynNvimConfig
      opts = {
        -- your configuration comes here; leave empty for default settings
      },
    },

    {
      "kawre/leetcode.nvim",
      --build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
      dependencies = {
        -- include a picker of your choice, see picker section for more details
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
      },
      opts = {
        -- configuration goes here
      },
    },

    {
      'jakewvincent/mkdnflow.nvim',
      config = function()
        require('mkdnflow').setup({})
      end
    },

    {
      "nickjvandyke/opencode.nvim",
      version = "*", -- Latest stable release
      dependencies = {
        {
          -- `snacks.nvim` integration is recommended, but optional
          ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
          "folke/snacks.nvim",
          optional = true,
          opts = {
            input = {}, -- Enhances `ask()`
            picker = {  -- Enhances `select()`
              actions = {
                opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
              },
              win = {
                input = {
                  keys = {
                    ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
                  },
                },
              },
            },
          },
        },
      },
      config = function()
        ---@type opencode.Opts
        vim.g.opencode_opts = {
          -- Your configuration, if any; goto definition on the type or field for details
        }

        vim.o.autoread = true -- Required for `opts.events.reload`

        -- Recommended/example keymaps
        vim.keymap.set({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end,
          { desc = "Ask opencode…" })
        vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end,
          { desc = "Execute opencode action…" })
        vim.keymap.set({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end, { desc = "Toggle opencode" })

        -- vim.keymap.set({ "n", "x" }, "go", function() return require("opencode").operator("@this ") end,
        --   { desc = "Add range to opencode", expr = true })
        -- vim.keymap.set("n", "goo", function() return require("opencode").operator("@this ") .. "_" end,
        --   { desc = "Add line to opencode", expr = true })

        vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,
          { desc = "Scroll opencode up" })
        vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end,
          { desc = "Scroll opencode down" })

        -- You may want these if you use the opinionated `<C-a>` and `<C-x>` keymaps above — otherwise consider `<leader>o…` (and remove terminal mode from the `toggle` keymap)
        vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
        vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
      end,
    },

    {
      "folke/snacks.nvim",
      priority = 1000,
      lazy = false,
      ---@type snacks.Config
      opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        bigfile = { enabled = true },
        dashboard = { enabled = false },
        explorer = { enabled = true },
        indent = { enabled = false },
        input = { enabled = true },
        picker = { enabled = true },
        notifier = { enabled = false },
        quickfile = { enabled = false },
        scope = { enabled = false },
        scroll = { enabled = false },
        statuscolumn = { enabled = false },
        words = { enabled = false },
      },
    },

    {
      'mrcjkb/rustaceanvim',
      version = '^8', -- Recommended
      lazy = false,   -- This plugin is already lazy
    },

    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      },
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
  },


  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "vague" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

local vue_plugin = {
  name = '@vue/typescript-plugin',
  location = vim.fn.stdpath 'data' .. '/mason/packages/vue-language-server/node_modules/@vue/language-server',
  languages = { 'vue' },
  configNamespace = 'typescript',
}

local ts_ls_config = {
  init_options = {
    plugins = {
      vue_plugin,
    },
  },
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
}

local vue_ls_config = {}

local tailwindcss_ls_config = {
  filetypes = { 'javascriptreact', 'typescriptreact', 'vue' }
}


vim.lsp.config('vue_ls', vue_ls_config)
vim.lsp.config('ts_ls', ts_ls_config)
vim.lsp.config('tailwindcss', tailwindcss_ls_config)

vim.lsp.enable({ 'ts_ls', 'vue_ls', 'tailwindcss' })

vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
vim.keymap.set('n', 'gk', vim.diagnostic.open_float)

require("which-key").add({
  { "<leader>b", group = "buffer" },
  { "<leader>bb", "<cmd>Telescope buffers<cr>", desc = "List buffers" },
  { "<leader>bk", "<cmd>bd<cr>", desc = "Kill buffer" },
  { "<leader>bn", "<cmd>bn<cr>", desc = "Next buffer" },
  { "<leader>bp", "<cmd>bp<cr>", desc = "Previous buffer" },

  { "<leader>c", group = "code" },
  { "<leader>ca", vim.lsp.buf.code_action, desc = "Code action", mode = "n" },
  { "<leader>cf", vim.lsp.buf.format, desc = "Format buffer", mode = "n" },
  { "<leader>cm", function() require("conform").format({ async = true }) end, desc = "Format with conform", mode = "n" },
  { "<leader>cr", vim.lsp.buf.rename, desc = "Rename", mode = "n" },
  { "cR", "<cmd>Telescope lsp_references<cr>", desc = "LSP references" },
  { "cs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols" },
  { "cS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace symbols" },

  { "<leader>d", group = "debug" },
  { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint", mode = "n" },
  { "<leader>dc", function() require("dap").continue() end, desc = "Continue", mode = "n" },
  { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to cursor", mode = "n" },
  { "<leader>dT", function() require("dap").terminate() end, desc = "Terminate", mode = "n" },
  { "<leader>du", function() require("dapui").toggle({}) end, desc = "Toggle UI", mode = "n" },

  { "<leader>e", group = "error" },
  { "<leader>en", vim.diagnostic.goto_next, desc = "Next diagnostic", mode = "n" },
  { "<leader>ep", vim.diagnostic.goto_prev, desc = "Previous diagnostic", mode = "n" },

  { "<leader>f", group = "file" },
  { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
  { "<leader>fm", "<cmd>!Open -a Finder %:p:h<cr>", desc = "Open in Finder" },
  { "<leader>fo", "<cmd>Oil<cr>", desc = "Oil file manager" },
  { "<leader>fp", "<cmd>e ~/.config/nvim/init.lua<cr>", desc = "Edit init.lua" },
  { "<leader>ft", "<cmd>e ~/.config/templates/template.typ<cr>", desc = "Edit template.typ" },

  { "<leader>g", group = "git" },
  { "<leader>gc", "<cmd>LazyGitCurrentFile<cr>", desc = "LazyGit current file" },
  { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview open" },
  { "<leader>gD", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview file history" },
  { "<leader>gf", "<cmd>LazyGitFilter<cr>", desc = "LazyGit filter" },
  { "<leader>gF", "<cmd>LazyGitFilterCurrentFile<cr>", desc = "LazyGit filter current file" },
  { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
  { "<leader>gl", "<cmd>LazyGitLog<cr>", desc = "LazyGit log" },

  { "<leader>h", group = "help" },
  { "<leader>hk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },

  { "<leader>l", group = "tools" },
  { "<leader>lb", "<cmd>set tw=80<cr><cmd>set fo+=t<cr>", desc = "Set textwidth 80" },
  { "<leader>ll", "<cmd>Lazy<cr>", desc = "Lazy" },
  { "<leader>lm", "<cmd>Mason<cr>", desc = "Mason" },

  { "<leader>k", function() require("dict").lookup() end, desc = "Dictionary lookup", mode = "n" },

  { "<leader>s", group = "search" },
  { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search buffer" },
  { "<leader>ss", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },

  { "<leader>t", group = "test" },
  { "<leader>td", function() require("neotest").run.run({strategy = "dap"}) end, desc = "Debug test", mode = "n" },
  { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Test file", mode = "n" },
  { "<leader>tr", function() require("neotest").run.run() end, desc = "Run test", mode = "n" },
  { "<leader>ts", function() require("neotest").run.stop() end, desc = "Stop test", mode = "n" },
  { "<leader>tt", "<cmd>Neotest summary<cr>", desc = "Test summary" },

  { "<leader>x", group = "trouble" },
  { "<leader>xg", "<cmd>Trouble diagnostics toggle<cr>", desc = "Global diagnostics" },
  { "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },
  { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location list" },
  { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },
})
