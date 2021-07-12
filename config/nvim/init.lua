-- ALIASES --------------------------------------------------------------------

local cmd = vim.cmd
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options
local map = vim.api.nvim_set_keymap -- see :h :map-arguments

-- SETTINGS -------------------------------------------------------------------

opt.backup = false                 -- no need to backup before overwriting
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
opt.wildmode = {'list:longest', 'list:full'} -- tab completion
opt.wrap = false                   -- disable line wrapping

g.mapleader = ','

-- PLUGIN CONFIGURATION -------------------------------------------------------

require('plugins')

cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua

-- MATERIAL

require('material').set()
g.material_style = 'palenight'
g.material_italic_comments = true
g.material_borders = true

-- TELESCOPE

map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { noremap = true })
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { noremap = true })
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { noremap = true })
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { noremap = true })

-- TREE-SITTER
local ts = require 'nvim-treesitter.configs'
ts.setup {
  ensure_installed = 'maintained',
  highlight = {
    enable = true
  },
  rainbow = {
    enable = true,
    extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
  }
}

-- LIGHTBULB
cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]

-- DEVICONS

require'nvim-web-devicons'.setup {
  default = true
}

-- DASHBOARD
g.dashboard_default_executive = 'telescope'

-- FUGITIVE
cmd [[autocmd BufReadPost fugitive://* set bufhidden=delete]] -- Auto-delete Fugitive buffers once I leave them

-- HIGHLIGHT ON YANK
cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'  -- disabled in visual mode

-- LSP Configuration
-- @see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
local nvim_lsp = require 'lspconfig'

-- NB: This is the config displayed on the README. May need to tweak.
local on_attach = function (client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", '<leader>f', "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

-- TODO https://github.com/kabouzeid/nvim-lspinstall/pull/106
nvim_lsp.ember.setup {
  on_attach = on_attach,
  cmd = { "npx", "ember-language-server", "--stdio" }
}

require'lspinstall'.setup()

local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
  nvim_lsp[server].setup{}
end

-- AUTOCOMPLETION
-- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion

vim.o.completeopt = "menuone,noselect"

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    nvim_lsp = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

map("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
map("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

-- MAPPINGS -------------------------------------------------------------------

-- Press this with terminal output to enter normal mode so you can scroll
-- through terminal output
map('t', '<C-o>', '<C-\\><C-n>', {})

-- Clear highlighted search
map('n', '<leader>/', '<cmd>:let @/=""<cr>', { noremap = true })

-- Find and replace under cursor
map('n', '<leader>s', ':%s/\\<<C-r><C-w>\\>/', { noremap = true })

-- Tree plugin
map('n', '<F2>', ':NvimTreeToggle<cr>', { noremap = true })

-- vim-test

map('n', '<silent> <leader>t', ':TestNearest -strategy=neovim<CR>', {})
map('n', '<silent> <leader>T', ':TestFile -strategy=neovim<CR>', {})
map('n', '<silent> <leader>S', ':TestSuite -strategy=neovim<CR>', {})
map('n', '<silent> <leader>l', ':TestLast<CR>', {})
map('n', '<silent> <leader>g', ':TestVisit<CR>', {})

-- RESOURCES ------------------------------------------------------------------
-- https://github.com/nanotee/nvim-lua-guide
-- https://oroques.dev/notes/neovim-init/
