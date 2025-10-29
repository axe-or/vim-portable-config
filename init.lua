local tab_size = 4
local jk_esc = true

local function set_options(t, scope)
	if not scope then scope = 'default' end
	local opt_map = {
		['default'] = 'opt',
		['local']   = 'opt_local',
		['global']  = 'opt_global',
	}
	local opt = opt_map[scope]
	assert(opt, 'Unknown value for config scope')
	for k, v in pairs(t) do
		vim[opt][k] = v
	end
end

local function map_key(mode, seq, cmd, options)
	if not options then
		options = {noremap = true, silent = true}
	end
	vim.keymap.set(mode, seq, cmd, options)
end

set_options {
	compatible = false,
	tabstop = tab_size,
	shiftwidth = tab_size,
	backup = false,
	hidden = true,
	cmdheight = 1,
	completeopt = { 'menuone', 'noselect' },
	conceallevel = 0,
	fileencoding = 'utf-8',
	hlsearch = false,
	incsearch = true,
	ignorecase = true,
	mouse = 'a',
	pumheight = 10,
	showmode = false,
	showtabline = 2,
	laststatus = 2,
	smartcase = true,
	splitbelow = true,
	splitright = true,
	swapfile = false,
	timeoutlen = 800,
	undofile = false,
	updatetime = 300,
	smartindent = true,
	writebackup = false,
	expandtab = false,
	termguicolors = true,
	cursorline = false,
	number = true,
	relativenumber = false,
	numberwidth = 3,
	signcolumn = 'no',
	wrap = false,
	foldmethod = 'indent',
	foldlevelstart = 99,
	scrolloff = 8,
	sidescrolloff = 12,
	background = 'dark',
}

local netrw_options = {
	keepdir = 0,
	banner = 0,
	hide = 1,
	winsize = 30,
}

for name, value in pairs(netrw_options) do
	vim.g['netrw_'..name] = value
end

-- Stop making line comments when pressing o, this abomination is required
-- because Vim's ftplugins are fucking retarded.
vim.cmd [[autocmd FileType * set formatoptions-=o]]
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

map_key("", "<Space>", "<Nop>")
map_key("", "Q", "<Nop>")
map_key("", "K", "<Nop>")

map_key('n', '<C-s>', ':w<CR>')
map_key('i', '<C-s>', '<ESC>:w<CR>')
map_key('n', '<C-k>', '<C-u>zz')
map_key('n', '<C-j>', '<C-d>zz')

map_key('n', 'Y', 'y$')
map_key('n', 'D', 'd$')
map_key('n', 'C', 'c$')
map_key('n', '<C-a>', ':normal ggVG<CR>')

map_key('n', 'L', ':bnext<CR>')
map_key('n', 'H', ':bprevious<CR>')

map_key('n', '<leader>n', ':enew<CR>')
map_key('n', '<leader>q', ':close<CR>')
map_key('n', '<leader>x', ':bdelete<CR>')
map_key('n', '<leader>X', ':bdelete!<CR>')
map_key('n', '<leader>l', ':noh<CR>:echo<CR>')
map_key('n', '<leader>c', ':Commentary<CR>')
map_key('v', '<leader>c', ':Commentary<CR>')

map_key('n', '<leader>sh', ':split<CR>')
map_key('n', '<leader>sv', ':vsplit<CR>')

map_key('n', '<C-o>', '<C-w>w')
map_key('n', '<C-b>', ':Compile<CR>')
map_key('n', '<C-c><C-b>', ':CompileSetCommands<CR>')
map_key('n', '<C-c><C-t>', ':CompileTest<CR>')

require('nvim-treesitter.configs').setup {
	sync_install = true, -- Enable if you have <8GB RAM, will take much longer to compile
	ensure_installed = {},

	ignore_install = {'phpdoc', 'javadoc', 'v'},

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},

	indent = {
		enable = true,
	},
}

vim.cmd [[ colorscheme udark ]]

