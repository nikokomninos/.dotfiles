return {
  {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',
    opts = {
      keymap = {
        preset = 'enter',
        ['<C-k>'] = { 'select_prev', 'fallback_to_mappings' },
        ['<C-j>'] = { 'select_next', 'fallback_to_mappings' },
      },
      appearance = {
        nerd_font_variant = 'mono'
      },
      completion = {
        list = { selection = { auto_insert = false } },
        documentation = {
          auto_show = true,
          window = {
            border = "rounded",
          },
        },
        menu = {
          border = "rounded",
          draw = {
            gap = 2,
            components = {
              source_name = {
                text = function(ctx)
                  if ctx.source_name == "LSP" then return "[LSP]" end
                  if ctx.source_name == "Snippets" then return "[SNIP]" end
                  if ctx.source_name == "Buffer" then return "[BUF]" end
                  if ctx.source_name == "Path" then return "[PATH]" end
                end,
              },
            },
            columns = {
              { "kind_icon",   "kind",              gap = 2 },
              { "label",       "label_description", gap = 1 },
              { "source_name", gap = 1 },
            },
          },
        },
      },
      sources = {
        default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
  },

  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp"
  },
}
