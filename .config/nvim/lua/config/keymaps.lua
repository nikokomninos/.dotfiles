vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
vim.keymap.set('n', 'gk', vim.diagnostic.open_float)

require("which-key").add({
  { "<leader>b",  group = "buffer" },
  { "<leader>bb", "<cmd>Telescope buffers<cr>",                                    desc = "List buffers" },
  { "<leader>bk", "<cmd>bd<cr>",                                                   desc = "Kill buffer" },
  { "<leader>bn", "<cmd>bn<cr>",                                                   desc = "Next buffer" },
  { "<leader>bp", "<cmd>bp<cr>",                                                   desc = "Previous buffer" },

  { "<leader>c",  group = "code" },
  { "<leader>ca", vim.lsp.buf.code_action,                                         desc = "Code action",                mode = "n" },
  { "<leader>cf", vim.lsp.buf.format,                                              desc = "Format buffer",              mode = "n" },
  { "<leader>cm", function() require("conform").format({ async = true }) end,      desc = "Format with conform",        mode = "n" },
  { "<leader>cr", vim.lsp.buf.rename,                                              desc = "Rename",                     mode = "n" },
  { "<leader>cR",         "<cmd>Telescope lsp_references<cr>",                             desc = "LSP references" },
  { "<leader>cs",         "<cmd>Telescope lsp_document_symbols<cr>",                       desc = "Document symbols" },
  { "<leader>cS",         "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",              desc = "Workspace symbols" },

  { "<leader>d",  group = "debug" },
  { "<leader>db", function() require("dap").toggle_breakpoint() end,               desc = "Toggle breakpoint",          mode = "n" },
  { "<leader>dc", function() require("dap").continue() end,                        desc = "Continue",                   mode = "n" },
  { "<leader>dC", function() require("dap").run_to_cursor() end,                   desc = "Run to cursor",              mode = "n" },
  { "<leader>dT", function() require("dap").terminate() end,                       desc = "Terminate",                  mode = "n" },
  { "<leader>du", function() require("dapui").toggle({}) end,                      desc = "Toggle UI",                  mode = "n" },

  { "<leader>e",  group = "error" },
  { "<leader>en", function() vim.diagnostic.jump({ count = 1 }) end,               desc = "Next diagnostic",            mode = "n" },
  { "<leader>ep", function() vim.diagnostic.jump({ count = -1 }) end,              desc = "Previous diagnostic",        mode = "n" },

  { "<leader>f",  group = "file" },
  { "<leader>ff", "<cmd>Telescope find_files<cr>",                                 desc = "Find files" },
  { "<leader>fm", "<cmd>!Open -a Finder %:p:h<cr>",                                desc = "Open in Finder" },
  { "<leader>fo", "<cmd>Oil<cr>",                                                  desc = "Oil file manager" },
  { "<leader>fp", "<cmd>e ~/.config/nvim/init.lua<cr>",                            desc = "Edit init.lua" },
  { "<leader>ft", "<cmd>e ~/.config/templates/template.typ<cr>",                   desc = "Edit template.typ" },

  { "<leader>g",  group = "git" },
  { "<leader>gb", "<cmd>Telescope git_branches<cr>",                                 desc = "Switch branch" },
  { "<leader>gc", "<cmd>LazyGitCurrentFile<cr>",                                   desc = "LazyGit current file" },
  { "<leader>gd", "<cmd>DiffviewOpen<cr>",                                         desc = "Diffview open" },
  { "<leader>gD", "<cmd>DiffviewFileHistory<cr>",                                  desc = "Diffview file history" },
  { "<leader>gf", "<cmd>LazyGitFilter<cr>",                                        desc = "LazyGit filter" },
  { "<leader>gF", "<cmd>LazyGitFilterCurrentFile<cr>",                             desc = "LazyGit filter current file" },
  { "<leader>gg", "<cmd>LazyGit<cr>",                                              desc = "LazyGit" },
  { "<leader>gl", "<cmd>LazyGitLog<cr>",                                           desc = "LazyGit log" },

  { "<leader>h",  group = "help" },
  { "<leader>hk", "<cmd>Telescope keymaps<cr>",                                    desc = "Keymaps" },

  { "<leader>l",  group = "tools" },
  { "<leader>lb", "<cmd>set tw=80<cr><cmd>set fo+=t<cr>",                          desc = "Set textwidth 80" },
  { "<leader>ll", "<cmd>Lazy<cr>",                                                 desc = "Lazy" },
  { "<leader>lm", "<cmd>Mason<cr>",                                                desc = "Mason" },

  { "<leader>s",  group = "search" },
  { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>",                  desc = "Search buffer" },
  { "<leader>ss", "<cmd>Telescope live_grep<cr>",                                  desc = "Live grep" },
  { "<leader>sr", "<cmd>GrugFar<cr>",                                  desc = "Live find and replace" },

  { "<leader>t",  group = "test" },
  { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug test",                 mode = "n" },
  { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end,   desc = "Test file",                  mode = "n" },
  { "<leader>tr", function() require("neotest").run.run() end,                     desc = "Run test",                   mode = "n" },
  { "<leader>ts", function() require("neotest").run.stop() end,                    desc = "Stop test",                  mode = "n" },
  { "<leader>tt", "<cmd>Neotest summary<cr>",                                      desc = "Test summary" },

  { "<leader>x",  group = "trouble" },
  { "<leader>xg", "<cmd>Trouble diagnostics toggle<cr>",                           desc = "Global diagnostics" },
  { "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",              desc = "Buffer diagnostics" },
  { "<leader>xl", "<cmd>Trouble loclist toggle<cr>",                               desc = "Location list" },
  { "<leader>xq", "<cmd>Trouble qflist toggle<cr>",                                desc = "Quickfix list" },
})

