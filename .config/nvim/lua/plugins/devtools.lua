return {
  {
    'barrett-ruth/live-server.nvim',
    build = 'pnpm add -g live-server',
    cmd = { 'LiveServerStart', 'LiveServerStop' },
    config = true
  },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter"
    }
  },

  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "mason-org/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",
    },
    config = function ()
      require("mason-nvim-dap").setup({
        ensure_installed = { "codelldb" },
        handlers = {},
      })

      local dap = require("dap")
      dap.configurations.cpp = {
        setmetatable({
          name = "Launch executable",
          type = "codelldb",
          request = "launch",
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        }, {
          __call = function ()
            local path = vim.fn.input({
              prompt = "Path to executable: ",
              default = vim.fn.getcwd() .. "/",
              completion = "file",
            })
            if path == "" then
              return { program = dap.ABORT }
            end
            local args = vim.fn.input("Arguments: ")
            return {
              name = "Launch executable",
              type = "codelldb",
              request = "launch",
              program = path,
              args = vim.split(args, " ", { trimempty = true }),
              cwd = "${workspaceFolder}",
              stopOnEntry = false,
            }
          end,
        }),
      }
      dap.configurations.c = dap.configurations.cpp
    end
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    opts = {},
    config = function (_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)

      dap.listeners.before.attach.dapui_config = function ()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function ()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function ()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function ()
        dapui.close()
      end
    end,
  },

  {
    "mgierada/lazydocker.nvim",
    dependencies = { "akinsho/toggleterm.nvim" },
    config = function ()
      require("lazydocker").setup({
        border = "curved",
        width = 0.9,
        height = 0.9
      })
    end,
    event = "BufRead"
  },

  {
    "LostbBlizzard/lazysql.nvim",
    opts = {}, -- automatically calls `require("lazysql").setup()`
    dependencies = {
      "MunifTanjim/nui.nvim"
    }
  }
}

