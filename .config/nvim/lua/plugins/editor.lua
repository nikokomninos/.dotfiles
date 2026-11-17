return {
  { 'NMAC427/guess-indent.nvim' },
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
    'MagicDuck/grug-far.nvim',
    config = function()
      require('grug-far').setup({
      });
    end
  },

  { 'Bekaboo/deadcolumn.nvim' },

  {
    "kylechui/nvim-surround",
    version = "^4.0.0",
    event = "VeryLazy",
  },

  {
    'derektata/lorem.nvim',
    config = function()
      require("lorem").opts {
        sentence_length = "mixed",
        comma_chance = 0.3,
        max_commas = 2,
        debounce_ms = 200,
      }
    end
  },

  -- {
  --   'andweeb/presence.nvim',
  --   config = function()
  --     local presence = require("presence")
  --     presence.setup({
  --       main_image = "file"
  --     })
  --   end
  -- },
}
