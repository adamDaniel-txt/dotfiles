let mapleader =" "

if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall | qa
endif

map ,, :keepp /<++><CR>ca<
imap ,, <esc>:keepp /<++><CR>ca<

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'ellisonleao/gruvbox.nvim'
Plug 'echasnovski/mini.nvim'
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
Plug 'vimwiki/vimwiki'
Plug 'alvan/vim-closetag'
Plug 'ap/vim-css-color'
call plug#end()

set mouse=a
set nohlsearch
set ignorecase
set clipboard+=unnamedplus
set laststatus=2
set cursorline
set undofile
set noswapfile
colorscheme gruvbox

" call mini modules
lua require('mini.ai').setup()
lua require('mini.pick').setup()
lua require('mini.files').setup()
lua require('mini.pairs').setup()
lua require('mini.icons').setup()
lua require('mini.fuzzy').setup()
lua require('mini.comment').setup()
lua require('mini.starter').setup()
lua require('mini.snippets').setup()
lua require('mini.surround').setup()
lua require('mini.bracketed').setup()
lua require('mini.statusline').setup()
lua require('mini.completion').setup()

let g:coc_disable_startup_warning = 1

" Some basics:
nnoremap c "_c
filetype plugin on
syntax on
set encoding=utf-8
set number relativenumber
" Enable autocompletion:
set wildmode=longest,list,full
" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
set splitbelow splitright
" Goyo plugin makes text more readable when writing prose:
map <leader>f :Goyo \| set linebreak<CR>
let g:goyo_height='85%'
let g:goyo_width='80%'
" Spell-check set to <leader>o, 'o' for 'orthography':
map <leader>o :setlocal spell! spelllang=en_us<CR>

" install nessesary extension
let g:coc_global_extensions = [
			\ 'coc-lua',
			\ 'coc-css',
			\ 'coc-html',
			\ 'coc-eslint',
			\ ]

nmap <F2> <Plug>(coc-rename)

" disable pairs character '<' for html
autocmd FileType html let b:coc_pairs_disabled = ['<']

" auto pair for html tags"
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.php'

" open split terminal
map <leader>t :sp \| :term<CR>

" open mini.pick
map <leader><leader> :Pick buffers<CR>
map <leader>h :Pick help<CR>
" open mini.files
map <leader>n :lua MiniFiles.open()<CR>

" Shortcutting split navigation, saving a keypress:
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Replace ex mode with gq
map Q gq

" Check file in shellcheck:
map <leader>s :!clear && shellcheck -x %<CR>

" Open bibliography file
map <leader>b :vsp<space>~/.local/share/index.bib<CR>

" replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

" compile/run file
map <leader>m :w! \| :make<CR>
" open preview like pdf/html
map <leader>p :!opout "%:p"<CR>

" Ensure files are read as what I want:
let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
map <leader>v :VimwikiIndex<CR>
let g:vimwiki_list = [{'path': '~/sync/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

" Save file as sudo on files that require root permission
cabbrev w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Automatically deletes all trailing whitespace and newlines at end of file on save. & reset cursor position
autocmd BufWritePre * let currPos = getpos(".")
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e
autocmd BufWritePre *.[ch] %s/\%$/\r/e " add trailing newline for ANSI C standard
autocmd BufWritePre *neomutt* %s/^--$/-- /e " dash-dash-space signature delimiter in emails
autocmd BufWritePre * cal cursor(currPos[1], currPos[2])

" Run xrdb whenever Xdefaults or Xresources are updated.
autocmd BufRead,BufNewFile Xresources,Xdefaults,xresources,xdefaults set filetype=xdefaults
autocmd BufWritePost Xresources,Xdefaults,xresources,xdefaults !xrdb %

"" Turns off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable.
if &diff
	highlight! link DiffText MatchParen
endif
