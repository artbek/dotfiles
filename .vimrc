""" SETTINGS

" external plugins

execute pathogen#infect()
let g:ctrlp_cmd = 'CtrlPBuffer'


" vim built-in

colorscheme kolor
set fileencoding=utf8
set fileformats=unix,dos,mac

set backspace=indent,eol,start
filetype plugin indent on
syntax on

set nobackup
set nowritebackup
set noswapfile
if v:version > 702
	set noundofile
endif

" some people can't live without their arrows
if ($VIM_NOESCKEYS == 1)
	set noesckeys
endif

set ignorecase
set smartcase
set hlsearch
set incsearch
set nocursorline
set nocursorcolumn

set showcmd
set hidden

set tabstop=2
set shiftwidth=2
set wrap
set linebreak

"set autochdir
let g:netrw_altfile = 1

set laststatus=2
set statusline=%m\ %t\ [%{&l:fileformat}]\ %=%l/%L\ (%c)\ %P\

set scroll=1

if has("autocmd")
	if ($VIM_CHANGE_CURSOR_SHAPE == 1)
		let &t_SI = "\<Esc>[\x36 q"
		let &t_EI = "\<Esc>[\x30 q"
		au VimLeave * silent !echo -ne "\e[\x30 q"
	endif
	au! BufWritePost *.php call PhpSyntax()
endif

let mapleader = ","
set timeoutlen=200



""" KEY BINDINGS

" XML format
nnoremap <F6> :%s/></>\r</g<CR><S-V>gg=

" XML close tag
inoremap <leader>x </<C-x><C-o><Right>

" general
nnoremap <F8> :noh<CR>:call clearmatches()<CR>
nnoremap <F9> :call Bbuf2()<CR>
nnoremap <S-F9> :e.<CR>
nnoremap <C-k><C-k> :b#<CR>

" CTRL-S save (+ 'ssty -ixon' in .bashrc)
nnoremap <C-s> :update<CR>
inoremap <C-s> <Esc>:update<CR>
vnoremap <C-s> <Esc>:update<CR>

" trailig spaces
nnoremap <leader>e :%s/\s\+$//<CR>

" ctags
nmap <C-t> :call PopFromTagStack()<CR>
nnoremap <leader>t g<C-]>

" PHP
inoremap <leader>a ->
inoremap <leader>v var_dump();<LEFT><LEFT>
vnoremap <leader>v cvar_dump(<Esc>pa);
nnoremap <leader>v viwohyovar_dump(<Esc>pa); die;



""" FUNCTIONS

fun! PhpSyntax()
	let l:php_syntax_output = system('php -l ' . bufname('%'))
	let l:sphp = split(l:php_syntax_output, "\n")

	if (l:sphp[0] !~ "No syntax errors detected")
		let l:line_number = split(substitute(l:sphp[0], "\r", "", ""), " ")[-1]
		execute "normal " . (l:line_number) . "gg"
		for l:line in l:sphp
			let l:line = substitute(l:line, "\r", "", "")
			echom l:line
		endfor
	endif
endfun


if has("listcmds")

	fun! DeleteAllBuffers()
		redir => l:buflist
		silent ls
		redir END

		let l:bufitems = split(l:buflist, "\n")
		let l:buffers_string = ''
		for l:i in l:bufitems
			let l:items = split(l:i, ' ')
			let l:buffers_string = l:buffers_string . ' ' . l:items[0]
		endfor
		execute("bd " . l:buffers_string)
	endfun

endif


fun! PopFromTagStack()
	let l:prev_buffer = bufname('%')
	pop
	let l:curr_buffer = bufname('%')
	if (l:curr_buffer != l:prev_buffer)
		bd #
	endif
endfun

