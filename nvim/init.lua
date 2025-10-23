-- ===========================
-- Leader key
-- ===========================
vim.g.mapleader = " "

-- ===========================
-- Plugin manager: vim-plug
-- ===========================
vim.cmd [[
call plug#begin(stdpath('data') . '/plugged')

" Themes
Plug 'patstockwell/vim-monokai-tasty'
Plug 'tanvirtin/monokai.nvim'
Plug 'sjl/badwolf'
Plug 'morhetz/gruvbox'

" Essentials
Plug 'tpope/vim-sensible'
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'chrisbra/vim-diff-enhanced'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Git & QoL
Plug 'lewis6991/gitsigns.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'folke/which-key.nvim'

" (Optional) completion + snippets — harmless without LSPs
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

call plug#end()
]]

-- ===========================
-- Basic options
-- ===========================
local opt = vim.opt
opt.number = true
opt.scrolloff = 3
opt.wrap = false
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.termguicolors = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.splitbelow = true
opt.splitright = true
opt.updatetime = 300
opt.signcolumn = "yes"

-- ===========================
-- Colorscheme
-- ===========================
vim.cmd([[
syntax enable
filetype plugin indent on
set background=dark
colorscheme badwolf
]])

-- ===========================
-- Keymaps
-- ===========================
local map = vim.keymap.set
local kmopts = { noremap = true, silent = true }

map("i", "jk", "<Esc>", kmopts)
map("n", "<F2>", ":NERDTreeToggle<CR>", kmopts)
map("n", "<leader>v", ":vsplit<CR>", kmopts)
map("n", "<leader>h", ":split<CR>", kmopts)
map("n", "<leader>/", ":Commentary<CR>", kmopts)
map("v", "<leader>/", ":Commentary<CR>", kmopts)

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", kmopts)
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", kmopts)
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", kmopts)
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", kmopts)

-- Diagnostics (still useful for Treesitter/others; no LSP required)
map("n", "<leader>xx", "<cmd>Telescope diagnostics<CR>", kmopts)
map("n", "[d", vim.diagnostic.goto_prev, kmopts)
map("n", "]d", vim.diagnostic.goto_next, kmopts)
map("n", "<leader>e", vim.diagnostic.open_float, kmopts)
map("n", "<leader>q", vim.diagnostic.setloclist, kmopts)

-- ===========================
-- Plugin setups
-- ===========================
pcall(function() require("which-key").setup({}) end)

require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "python", "rust", "bash", "json", "yaml", "html", "css", "javascript", "go" },
  highlight = { enable = true },
  indent   = { enable = true },
})

pcall(function() require("gitsigns").setup({}) end)
pcall(function() require("nvim-autopairs").setup({}) end)
pcall(function() require("telescope").setup({}) end)

-- ===========================
-- (Optional) completion without LSPs
-- ===========================
local ok_cmp, cmp = pcall(require, "cmp")
local ok_snip, luasnip = pcall(require, "luasnip")
if ok_snip then require("luasnip.loaders.from_vscode").lazy_load() end

if ok_cmp then
  cmp.setup({
    snippet = { expand = function(args) if ok_snip then luasnip.lsp_expand(args.body) end end },
    mapping = cmp.mapping.preset.insert({
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
      { name = "buffer" },
      { name = "path" },
    }),
  })
end

-- ===========================
-- Pretty diagnostic signs (no LSP needed)
-- ===========================
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- ===========================
-- Lightline
-- ===========================
-- Uses current colorscheme.

