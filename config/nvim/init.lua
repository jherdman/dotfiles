-- ALIASES

local cmd = vim.cmd
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options
local map = vim.api.nvim_set_keymap -- see :h :map-arguments

-- SETTINGS

opt.backup = false                 -- no need to backup before overwriting
opt.backspace = 'eol,start,indent' -- backspacing over everything in insert mode
opt.clipboard = 'unnamedplus'      -- mega clipboard
opt.cursorline = true              -- highlight line cursor is on
opt.expandtab = true               -- spaces, not tabs
opt.ignorecase = true              -- ignore case in search patterns, see "smartcase" below
opt.inccommand = 'split'           -- live substitution
opt.mouse = 'a'                    -- mouse in all mode
opt.number = true                  -- show line numbers
opt.ruler = true                   -- show position all of the time
opt.shiftwidth = 2                 -- indent size
opt.smartcase = true               -- if your search pattern contains uppercase, it's now case sensitive. NB: ignorecase must be set for this to work.
opt.smartindent = true             -- insert indents automatically
opt.swapfile = false               -- no need for swapfiles
opt.tabstop = 2                    -- number of spaces a <Tab> counts for
opt.termguicolors = true           -- 24-bit RGP colors
opt.wildmenu = true                -- tab completion on command line
opt.wildmode = {'list', 'longest'} -- tab completion
opt.wrap = false                   -- disable line wrapping

g.mapleader = ','

-- PLUGINS

require('plugins')

-- MATERIAL

require('material').set()
g.material_style = 'palenight'
g.material_italic_comments = true

-- TELESCOPE

map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { noremap = true })
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { noremap = true })
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { noremap = true })
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { noremap = true })

-- TREE-SITTER
local ts = require 'nvim-treesitter.configs'
ts.setup {
  ensure_installed = 'maintained',
  highlight = {enable = true}
}

-- LIGHTBULB
cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]

-- MAPPINGS

-- Press this with terminal output to enter normal mode so you can scroll
-- through terminal output
map('t', '<C-o>', '<C-\\><C-n>', {})

-- Clear hilighted search
map('n', '<leader>/', ':nohlsearch<cr>', { noremap = true })

-- Find and replace under cursor
map('n', '<leader>s', ':%s/\\<<C-r><C-w>\\>/', { noremap = true })
