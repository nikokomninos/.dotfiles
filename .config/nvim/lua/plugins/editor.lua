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
}
