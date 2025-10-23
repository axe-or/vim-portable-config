" Simple init.vim that's compatible with Neovim and Vim

let g:Tabsize=4
let g:JKEscape=v:true

" General options
set nocompatible
let &tabstop=g:Tabsize
let &shiftwidth=g:Tabsize
let &fillchars='vert: '
set nobackup
set hidden
" NOTE: Disabled because it causes MASSIVE startup :latency on windows
" set clipboard=unnamedplus
set cmdheight=1
set completeopt=menuone,noselect
set conceallevel=0
set fileencoding=utf-8
set nohlsearch
set incsearch
set ignorecase
set mouse=a
set pumheight=10
set noshowmode
set showtabline=2
set laststatus=2
set smartcase
set splitbelow
set splitright
set noswapfile
set timeoutlen=800
set noundofile
set updatetime=300
set smartindent
set nowritebackup
set noexpandtab
set termguicolors
set nocursorline
set number
set norelativenumber
set numberwidth=3
set signcolumn=no
set nowrap
set foldmethod=indent
set foldlevelstart=99
set scrolloff=8
set sidescrolloff=12
set background=dark

syntax on
colors udark

" Netrw Options
let g:netrw_keepdir = 0
let g:netrw_banner  = 0
let g:netrw_hide    = 1
let g:netrw_winsize = 30

" Keybindings
function! s:map(mode, trigger, action)
  execute a:mode . 'noremap <silent> ' . a:trigger . ' ' . a:action
endfunction

noremap <Space> <Nop>
let g:mapleader=' '
let g:maplocalleader=' '

noremap Q <Nop>
noremap K <Nop>
nmap gs ysiw

if g:JKEscape
  " The `^ ensures that the cursor stays on the last character typed
  call s:map('i', 'jk', '<ESC>`^') | call s:map('i', 'kj', '<ESC>`^')
endif

call s:map('n', '<C-s>', ':w<CR>')
call s:map('i', '<C-s>', '<ESC>:w<CR>')
call s:map('n', '<C-k>', '<C-u>zz')
call s:map('n', '<C-j>', '<C-d>zz')

call s:map('n', 'Y', 'y$')
call s:map('n', 'D', 'd$')
call s:map('n', 'C', 'c$')
call s:map('n', '<C-a>', ':normal ggVG<CR>')

call s:map('n', 'L', ':bnext<CR>')
call s:map('n', 'H', ':bprevious<CR>')

call s:map('n', '<leader>n', ':enew<CR>')
call s:map('n', '<leader>q', ':close<CR>')
call s:map('n', '<leader>x', ':bdelete<CR>')
call s:map('n', '<leader>X', ':bdelete!<CR>')
call s:map('n', '<leader>l', ':noh<CR>:echo<CR>')
call s:map('n', '<leader>c', ':Commentary<CR>')
call s:map('v', '<leader>c', ':Commentary<CR>')


" augroup ThemeOverrides
" 	autocmd!
" 	autocmd BufEnter
" 		\ hi! Normal guibg='NONE'
" augroup END

augroup NetrwKeys
  autocmd!
  autocmd FileType netrw
        \ nnoremap <buffer> <silent> cd :cd %<CR>
augroup END

augroup C_And_Cpp
  autocmd!
  autocmd FileType c,cpp
        \ inoremap <silent> <C-l> ->
augroup END

nnoremap <silent> <leader>f :Lexplore<CR>

nnoremap <silent> <leader>W :%s/\s\+$//<CR>
nnoremap <silent> <leader>sh :split<CR>
nnoremap <silent> <leader>sv :vsplit<CR>
nnoremap <C-o> <C-w>w

nnoremap <C-b> :Compile<CR>
nnoremap <C-c><C-b> :CompileSetCommands<CR>
nnoremap <C-c><C-t> :CompileTest<CR>

" inoremap <silent> <expr> <Tab>   pumvisible() ? '<C-n>' : '<Tab>'
" inoremap <silent> <expr> <S-Tab> pumvisible() ? '<C-p>' : '<S-Tab>'
" inoremap <silent> <expr> <CR>    pumvisible() ? ' ' : '<CR>'

vnoremap <silent> < <gv
vnoremap <silent> > >gv

xnoremap <silent> <C-k> :move '<-2<cr>gv-gv
xnoremap <silent> <C-j> :move '>+1<cr>gv-gv

let &statusline=' %m%f %= %y | %l:%c | %{&fileencoding} %{&fileformat} '

hi! Normal guibg='NONE'


