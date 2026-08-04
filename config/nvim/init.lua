-- function
local function pack_clean()
	local active_plugins = {}
	local unused_plugins = {}
	for _, plugin in ipairs(vim.pack.get()) do
		active_plugins[plugin.spec.name] = plugin.active
	end
	for _, plugin in ipairs(vim.pack.get()) do
		if not active_plugins[plugin.spec.name] then
			table.insert(unused_plugins, plugin.spec.name)
		end
	end
	if #unused_plugins == 0 then
		print("No unused plugins.")
		return
	end
	local choice = vim.fn.confirm("Remove unused plugins?", "&Yes\n&No", 2)
	if choice == 1 then
		vim.pack.del(unused_plugins)
	end
end

vim.g.mapleader = " "

vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.swapfile = false
vim.o.undofile = true
vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.cursorline = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.clipboard = 'unnamedplus'

vim.pack.add({
    {src = "https://github.com/nvim-telescope/telescope.nvim.git"},
    {src = "https://github.com/chomosuke/typst-preview.nvim.git"},
    {src = "https://github.com/sphamba/smear-cursor.nvim.git"},
    {src = "https://github.com/HakonHarnes/img-clip.nvim"},
    {src = "https://github.com/nvim-lua/plenary.nvim.git"},
    {src = "https://github.com/mikavilpas/yazi.nvim.git"},
    {src = "https://github.com/ellisonleao/gruvbox.nvim"},
    {src = "https://github.com/mason-org/mason.nvim.git"},
    {src = "https://github.com/pablopunk/pi.nvim.git"},
    {src = "https://github.com/nvim-mini/mini.nvim"},
    {src = "https://github.com/alvan/vim-closetag"},
    {src = "https://github.com/junegunn/goyo.vim"},
    {src = "https://github.com/ap/vim-css-color"},
    {src = "https://github.com/vimwiki/vimwiki"},
})

-- "junegunn/goyo.vim", { 'for': 'markdown' }
vim.cmd("colorscheme gruvbox")

-- keymap
local map = vim.keymap.set
-- basic
map('n', '<leader>r', ':update<CR> :source<CR>')
map('n', 'Q', 'gq')
map('n', 'S', ':%s//g<Left><Left>', { silent = false })
-- navi
map('', '<C-h>', '<C-w>h')
map('', '<C-j>', '<C-w>j')
map('', '<C-k>', '<C-w>k')
map('', '<C-l>', '<C-w>l')
-- placeholders (,,)
map('', ',,', ':keepp /<++><CR>ca<')
map('i', ',,', '<esc>:keepp /<++><CR>ca<')
-- shortcuts
-- map('', '<leader>c', ':w! | !compiler "%:p"<CR>')
map('', '<leader>m', ':w! | :make<CR>')
map('', '<leader>o', ':!opout "%:p"<CR>')
map('', '<leader>v', ':VimwikiIndex<CR>')
map('', '<leader>b', ':vsp ~/.local/share/index.bib<CR>')
map('', '<leader>pc', pack_clean)
-- plugin shortcuts
map('n', '<leader>ai', ':PiAsk<CR>', { desc = "Ask pi" })
map('v', '<leader>ai', ':PiAskSelection<CR>', { desc = "Ask pi (selection)" })
map('', '<leader>f', ':Goyo | set linebreak<CR>')
map('', '<leader>O', ':setlocal spell! spelllang=en_us<CR>')
map('', '<leader>pi', ':PasteImage<CR>')
map('', '<leader>t', ':sp | term<CR>')
map('', '<leader><leader>', ':Telescope find_files<CR>')
map('', '<leader>h', ':Pick help<CR>')
map('', '<leader>g', ':Pick grep_live<CR>')
map('', '<leader>G', ':Pick grep<CR>')
map('', '<leader>s', ':Pick files<CR>')
map('', '<leader>n', ':Yazi<CR>')
-- center
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- lsp
vim.lsp.enable('lua_ls')

-- autocmds
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- disable auto-commenting on newline
autocmd("FileType", {
    pattern = "*",
    command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o"
})
-- sent filetype
-- autocmd({"BufNewFile", "BufRead"}, {
--     pattern = "*.sent",
--     command = "setfiletype sent"
-- })
-- cleanup trailing whitespace and newlines on save
local white_group = augroup("WhiteSpaceClean", { clear = true })
autocmd("BufWritePre", {
    group = white_group,
    callback = function()
        local currPos = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        vim.cmd([[%s/\n\+\%$//e]])
        -- C specific trailing newline
        if vim.bo.filetype == 'c' or vim.bo.filetype == 'cpp' then
            vim.cmd([[%s/\%$/\r/e]])
        end
        vim.fn.setpos(".", currPos)
    end
})

-- setup plugins
vim.g.goyo_width = '80%'
vim.g.closetag_filenames = '*.html,*.xhtml,*.phtml,*.php'
vim.g.vimwiki_ext2syntax = {['.Rmd'] = 'markdown', ['.rmd'] = 'markdown', ['.md'] = 'markdown', ['.markdown'] = 'markdown', ['.mdown'] = 'markdown'}
vim.g.vimwiki_list = {{path = '~/sync/note/', syntax = 'markdown', ext = '.md'}}
-- vim.g.vimwiki_global_ext = 0

local mini_modules = {
  'ai', 'git', 'pick', 'diff', 'clue', 'files', 'pairs', 'icons',
  'fuzzy', 'notify', 'comment', 'cmdline', 'starter', 'tabline',
  'surround', 'bufremove', 'bracketed', 'operators', 'statusline',
  'indentscope', 'completion',
}

for _, name in ipairs(mini_modules) do
  require('mini.' .. name).setup()
end

require('mason').setup()

local gen_loader = require('mini.snippets').gen_loader
require('mini.snippets').setup({
  snippets = {
    gen_loader.from_file('~/.config/nvim/snippets/global.json'),
    gen_loader.from_lang(),
  },
})
require('mini.snippets').start_lsp_server({ match = false })

local miniclue = require('mini.clue')
miniclue.setup({
  triggers = {
    { mode = { 'n', 'x' }, keys = '<Leader>' }, -- leader triggers
    { mode = 'n', keys = '[' }, -- `[` and `]` keys
    { mode = 'n', keys = ']' },
    { mode = 'i', keys = '<C-x>' }, -- Built-in completion
    { mode = { 'n', 'x' }, keys = 'g' }, -- `g` key
    { mode = { 'n', 'x' }, keys = "'" }, -- Marks
    { mode = { 'n', 'x' }, keys = '`' },
    { mode = { 'n', 'x' }, keys = '"' }, -- Register
    { mode = { 'i', 'c' }, keys = '<C-r>' },
    { mode = { 'n', 'x' }, keys = 'z' }, -- `z` key
  },
  clues = {
    -- Enhance this by adding descriptions for <Leader> mapping groups
    miniclue.gen_clues.square_brackets(),
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },
})

require('smear_cursor').setup({
    smear_between_buffers = true,
    smear_between_neighbor_lines = true,
    scroll_buffer_space = true,
    legacy_computing_symbols_support = true,
    smear_insert_mode = true,
})
