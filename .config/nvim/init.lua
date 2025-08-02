vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.termguicolors = true
vim.o.clipboard = "unnamedplus"
vim.o.undofile = true
vim.o.winborder = "rounded"
vim.g.mapleader = " "
vim.o.tabstop = 4      
vim.o.shiftwidth = 4   
vim.o.expandtab = true 
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.cindent = true
vim.o.wrap = false

-- Package manager
local function bootstrap_pckr()
    local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

    if not (vim.uv or vim.loop).fs_stat(pckr_path) then
        vim.fn.system({
            'git',
            'clone',
            "--filter=blob:none",
            'https://github.com/lewis6991/pckr.nvim',
            pckr_path
        })
    end

    vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

require('pckr').add {
    'vague2k/vague.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'neovim/nvim-lspconfig',
    'mason-org/mason.nvim',
    'mason-org/mason-lspconfig.nvim',
    'ms-jpq/coq_nvim',
    'ms-jpq/coq.artifacts',
    'ms-jpq/coq.thirdparty',
    'nvim-treesitter/nvim-treesitter',
    'windwp/nvim-autopairs',
    'lewis6991/gitsigns.nvim',
    'nvim-tree/nvim-web-devicons',
    'stevearc/oil.nvim',
    'kylechui/nvim-surround',
    'nvim-orgmode/orgmode',
    'NeogitOrg/neogit',
    'sindrets/diffview.nvim'
}

-- Colorscheme

vim.cmd("colorscheme vague")
vim.cmd("hi statusline guibg=NONE")

-- Fuzzy finder

vim.keymap.set('n', '<leader>ff', ":Telescope find_files<CR>")
vim.keymap.set('n', '<leader>fg', ":Telescope live_grep<CR>")
vim.keymap.set('n', '<leader>bb', ":Telescope buffers<CR>")
vim.keymap.set('n', '<leader>fo', ":Oil<CR>")

-- LSP

require('mason').setup()
require('mason-lspconfig').setup {
    automatic_enable = true
}

require('nvim-treesitter.configs').setup({
    ensure_installed = { "lua", "javascript", "typescript", "rust" },
    highlight = { enable = true },
    indent = {
        enable = true,
    }
})

vim.cmd("COQnow -s")

vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename)
vim.keymap.set('n', '<leader>gd', vim.lsp.buf.declaration)
vim.keymap.set('n', '<leader>gD', vim.lsp.buf.definition)

vim.diagnostic.config({
    virtual_text = {
        spacing = 2,
    },
})

-- Misc

require('oil').setup({
    view_options = {
        show_hidden = true,
    },
})

require('nvim-autopairs').setup({
    event = "InsertEnter",
})

local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')

npairs.setup({ map_bs = false, map_cr = false })

vim.g.coq_settings = { keymap = { recommended = false } }

-- these mappings are coq recommended mappings unrelated to nvim-autopairs
remap('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
remap('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
remap('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
remap('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })

-- skip it, if you use another global object
_G.MUtils= {}

MUtils.CR = function()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
      return npairs.esc('<c-y>')
    else
      return npairs.esc('<c-e>') .. npairs.autopairs_cr()
    end
  else
    return npairs.autopairs_cr()
  end
end
remap('i', '<cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true })

MUtils.BS = function()
  if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
    return npairs.esc('<c-e>') .. npairs.autopairs_bs()
  else
    return npairs.autopairs_bs()
  end
end
remap('i', '<bs>', 'v:lua.MUtils.BS()', { expr = true, noremap = true })

require('gitsigns').setup()
require('nvim-surround').setup()
require('orgmode').setup()

vim.keymap.set('n', '<leader>fp', ':e ~/.config/nvim/init.lua<CR>')
vim.keymap.set('n', '<leader>bk', ':bd<CR>')
vim.keymap.set('n', '<leader>gg', ':Neogit<CR>')
