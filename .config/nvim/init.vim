let mapleader =" "

if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

map ,, :keepp /<++><CR>ca<
imap ,, <esc>:keepp /<++><CR>ca<

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'ellisonleao/gruvbox.nvim'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'echasnovski/mini.nvim'
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
Plug 'alvan/vim-closetag'
Plug 'vimwiki/vimwiki'
Plug 'ap/vim-css-color'
call plug#end()

set title
set cindent
set tabstop=2
set softtabstop=0 noexpandtab
set shiftwidth=2
set mouse=a
set nohlsearch
set ignorecase
set smartcase
set clipboard+=unnamedplus
set noshowmode
set noruler
set laststatus=2
set noshowcmd
set cursorline
set undofile
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
		" map <leader>f :Goyo \| set spell spelllang=en_us \| set linebreak<CR>
		map <leader>f :Goyo \| set linebreak<CR>
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

" open split terminal
	map <leader>t :sp \| :term<CR>

" fuzzy find buffers
	map <leader><leader> :Pick buffers<CR>

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

" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>

" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>c :w! \| !compiler "%:p"<CR>

" Open current buffer in Browser
	map <leader>p :execute ':silent !firefox %'<CR>

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear %

" Ensure files are read as what I want:
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
	map <leader>v :VimwikiIndex<CR>
	let g:vimwiki_list = [{'path': '~/.local/share/nvim/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
	autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex set filetype=tex

" Save file as sudo on files that require root permission
	cabbrev w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Enable Goyo by default for mutt writing
	autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo 80 | call feedkeys("jk")
	autocmd BufRead,BufNewFile /tmp/neomutt* map ZZ :Goyo!\|x!<CR>
	autocmd BufRead,BufNewFile /tmp/neomutt* map ZQ :Goyo!\|q!<CR>

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

" Function for toggling the bottom statusbar:
let s:hidden_all = 0
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
    endif
endfunction
nnoremap <leader>h :call ToggleHiddenAll()<CR>
" Load command shortcuts generated from bm-dirs and bm-files via shortcuts script.
" Here leader is ";".
" So ":vs ;cfz" will expand into ":vs /home/<user>/.config/zsh/.zshrc"
" if typed fast without the timeout.
silent! source ~/.config/nvim/shortcuts.vim
