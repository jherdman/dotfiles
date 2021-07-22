-- ALIASES --------------------------------------------------------------------

local cmd = vim.cmd
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options
local map = vim.api.nvim_set_keymap -- see :h :map-arguments

-- SETTINGS -------------------------------------------------------------------

opt.backup = false                 -- no need to backup before overwriting
--opt.clipboard:append {'unnamedplus'} -- mega clipboard FIXME https://github.com/neovim/neovim/pull/14962
opt.cursorline = true              -- highlight line cursor is on
opt.expandtab = true               -- spaces, not tabs
opt.ignorecase = true              -- ignore case in search patterns, see "smartcase" below
opt.inccommand = 'split'           -- live substitution
opt.iskeyword:append {'-'}         -- helpful in Ember
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
cmd 'autocmd BufNewFile,BufRead *.hbs setfiletype handlebars'
cmd 'autocmd BufRead,BufNewFile *.json,*.json5 setfiletype jsonc' -- tsconfig.json is actually jsonc, help TypeScript set the correct filetype
cmd 'autocmd BufRead,BufNewFile *.nix setfiletype nix' -- Nix

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
  indent = {
    enable = true
  },
  rainbow = {
    enable = true,
    extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
  }
}

-- DEVICONS
require'nvim-web-devicons'.setup {
  default = true
}

-- COLOURIZER
require'colorizer'.setup {
  css = { css = true };
}

-- DASHBOARD
g.dashboard_default_executive = 'telescope'

-- FUGITIVE
cmd [[autocmd BufReadPost fugitive://* set bufhidden=delete]] -- Auto-delete Fugitive buffers once I leave them

-- HIGHLIGHT ON YANK
cmd 'au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=false}' 

-- LSP Configuration
-- @see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
-- @see https://github.com/neovim/nvim-lspconfig/wiki/UI-customization
local nvim_lsp = require 'lspconfig'

vim.o.updatetime = 250
cmd [[autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})]]

local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }

for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end


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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspinstall'.setup()

local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
  nvim_lsp[server].setup {
    on_attach = on_attach,
    capabilities = capabilities
  }
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
    buffer = true;
    calc = false;
    luasnip = true;
    nvim_lsp = true;
    path = true;
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
local luasnip = require 'luasnip'
require("luasnip/loaders/from_vscode").lazy_load({ paths = { "~/.local/share/nvim/site/pack/packer/start/friendly-snippets" } })

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t '<C-n>'
  elseif luasnip.expand_or_jumpable() then
    return t '<Plug>luasnip-expand-or-jump'
  elseif check_back_space() then
    return t '<Tab>'
  else
    return vim.fn['compe#complete']()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t '<C-p>'
  elseif luasnip.jumpable(-1) then
    return t '<Plug>luasnip-jump-prev'
  else
    return t '<S-Tab>'
  end
end

-- Map tab to the above tab complete functiones
map('i', '<Tab>', 'v:lua.tab_complete()', { expr = true })
map('s', '<Tab>', 'v:lua.tab_complete()', { expr = true })
map('i', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
map('s', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })

-- Map compe confirm and complete functions
map('i', '<cr>', 'compe#confirm("<cr>")', { expr = true })
map('i', '<c-space>', 'compe#complete()', { expr = true })

-- MAPPINGS -------------------------------------------------------------------

-- Press this with terminal output to enter normal mode so you can scroll
-- through terminal output
map('t', '<C-o>', '<C-\\><C-n>', {})

-- Clear highlighted search
map('n', '<leader>/', '<cmd>:let @/=""<cr>', { noremap = true })

-- Find and replace under cursor
map('n', '<leader>s', ':%s/\\<<C-r><C-w>\\>/', { noremap = true })

-- Tree plugin
--map('n', '<F2>', ':NvimTreeToggle<cr>', { noremap = true })
--g.nvim_tree_hijack_netrw = false
--g.nvim_tree_hide_dotfiles = true
map('n', '<F2>', ':NERDTreeToggle<cr>', { noremap = true })

-- vim-test

map('n', '<leader>t', ':TestNearest -strategy=neovim<CR>', {})
map('n', '<leader>T', ':TestFile -strategy=neovim<CR>', {})
map('n', '<leader>S', ':TestSuite -strategy=neovim<CR>', {})
map('n', '<leader>l', ':TestLast<CR>', {})
map('n', '<leader>g', ':TestVisit<CR>', {})

-- RESOURCES ------------------------------------------------------------------
-- https://github.com/nanotee/nvim-lua-guide
-- https://oroques.dev/notes/neovim-init/
-- https://neovim.io/doc/user/lua.html
-- https://github.com/mjlbach/defaults.nvim/blob/064da3f173dc42d72c6a5ff49e0e2533e76b80a7/init.lua
