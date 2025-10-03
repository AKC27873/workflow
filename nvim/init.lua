-- ===========================
-- Leader key
-- ===========================
vim.g.mapleader = " "

-- ===========================
-- Plugin manager: vim-plug via vim.cmd
-- (you can switch to lazy.nvim later if you want)
-- ===========================
vim.cmd [[
call plug#begin(stdpath('data') . '/plugged')
Plug 'patstockwell/vim-monokai-tasty'
Plug 'tanvirtin/monokai.nvim'
Plug 'sjl/badwolf'
Plug 'sheerun/vim-polyglot'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-sensible'
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'ervandew/supertab'
Plug 'tpope/vim-commentary'
Plug 'chrisbra/vim-diff-enhanced'
Plug 'nvim-treesitter/nvim-treesitter'
call plug#end()
]]

-- ===========================
-- Basic options (lua style)
-- ===========================
local opt = vim.opt

-- General
opt.number = true
opt.scrolloff = 3
opt.wrap = false
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.termguicolors = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Tabs and indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Line numbers: show absolute number on current line, relative on others
vim.opt.number = true
-- vim.opt.relativenumber = true

-- Colorscheme
vim.cmd [[
syntax enable
filetype plugin indent on
set background=dark
colorscheme badwolf
]]

-- ===========================
-- Keymaps (lua style)
-- ===========================
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Quick escape from insert mode
map("i", "jk", "<Esc>", opts)

-- NERDTree toggle
map("n", "<F2>", ":NERDTreeToggle<CR>", opts)

-- Splits
map("n", "<leader>vs", ":vsplit $MYVIMRC<CR>", opts)
map("n", "<leader>v", ":vsplit<CR>", opts)
map("n", "<leader>s", ":split<CR>", opts)

-- Commentary
map("n", "<leader>/", ":Commentary<CR>", opts)

-- ===========================
-- Neovim enhancements
-- ===========================
-- LSP floating diagnostics example (if you add LSP later)
-- vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {
--   callback = function()
--     vim.diagnostic.open_float(nil, { focusable = false })
--   end,
-- })

