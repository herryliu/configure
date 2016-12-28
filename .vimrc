"-------------- Vundle ---------------------------
" Vundle plugin management

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" my plugin list
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'int3/vim-taglist-plus'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'oblitum/YouCompleteMe'
"Plugin 'jsholmes/YouCompleteMe'
"Plugin 'vim-scripts/AutoComplPop'
"Plugin 'derekwyatt/vim-fswitch'
"Plugin 'vim-scripts/Conque-Shell'
Plugin 'lrvick/Conque-Shell'
Plugin 'majutsushi/tagbar'
"Plugin 'scrooloose/syntastic'
Plugin 'mileszs/ack.vim'
Plugin 'easymotion/vim-easymotion'
"Plugin 'xuhdev/SingleCompile'
"Plugin 'tmhedberg/SimpylFold'
"Plugin 'myusuf3/numbers.vim'
Plugin 'tpope/vim-surround'
"Plugin 'chriskempson/base16-vim'
Plugin 'Wutzara/vim-materialtheme'
"Plugin 'vim-scripts/genutils'
"Plugin 'vim-scripts/tagselect'
Plugin 'asford/tagselect'
Plugin 'tpope/vim-fugitive'
Plugin 'Yggdroot/indentLine'
"Plugin 'zhaocai/GoldenView.Vim'
Plugin 'bkad/CamelCaseMotion'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"--------------- End of Vundle -----------------
"
"set the shell
set shell=/bin/bash
let $TMPDIR=$HOME."/tmp"
" color schemem
"color materialtheme
color desert

"let base16colorspace=256

"auto reload the of .vimrc
autocmd! bufwritepost .vimrc source %

" Better copy and paste
set pastetoggle=<F2>

"disable the x-look up which slow down the vim startup
"we are not rely any clipboard integation any more which is just purely xclip
"to deal with it
"set clipboard=unnamedplus
set clipboard=exclude:.*

" backspace
set bs=2
"set relativenumber
"set number

" Rebind <leader> key
let mapleader=","

" quicksave
noremap <C-Z> :update<CR>
vnoremap <C-Z> <C-C>:update<CR>
inoremap <C-Z> <C-O>:update<CR>

" bind Ctrl+<movement> keys instae of using Ctrl-W

map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <C-h> <C-w>h

" easier moving of code bloks
vnoremap < <gv " reselect after the move
vnoremap > >gv

" reformat the paragrah
vmap Q gp
nmap Q gqap

" syntax on
syntax on
set background=dark
set ruler

" search related set hlsearch
"set incsearch
set ignorecase
set smartcase

" disable some files
set nobackup
set nowritebackup
set noswapfile

" space and tab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" color scheme
set t_Co=256


" define space as leader key
let mapleader="\<Space>"

"Create horizontal/vertical splits
"map <C-w>_ :split<CR>
"map <C-w>\| :vsplit<CR>


" change the window size
map <C-w><C-h> :vertical resize -5 <CR>
map <C-w><C-j> :resize +5<CR>
map <C-w><C-k> :resize -5<CR>
map <C-w><C-l> :vertical resize +5 <CR>


"ctrl-p
" load Ctrlp for the word under cursor
" <C-\> will break into ex mode which can select data from
" line/buffer/register etc
"nmap <C-w><C-p> yt.:CtrlP<CR><C-R><C-A>
nmap <C-w><C-p> yt.:CtrlP<CR><C-\>c
" ctrl-p follows the symol link
let g:ctrlp_follow_symlinks=1
" ctrl-p doesn't change root directory
let g:ctrlp_working_path_mode = 0

" clear the highlight
map <C-w>n :nohl<CR>

" xclip copy
"vnoremap y y:call system("xclip -i -selection clipboard " , getreg("\""))<CR>
vnoremap y y:call CopyToClip()<CR>
function CopyToClip()
    "echom "CopyToClip"
    "echom "register:" . getreg("\"")
    let copyCmd = "echo \'". getreg("\"") . "\' | xclip -i -selection clipboard & "
    "echom copyCmd
    call system(copyCmd)
    
endfunction


" save/restore VIM session
map <F11> :mksession! ~/.vim_session <cr>
map <F12> :source ~/.vim_session <cr>

" draw a line below the active line
"set cursorline

" set the folding to syntax and open all level
set foldmethod=syntax
set foldlevel=999

" set the airline scheme
let g:airline_theme='light'

" cycle the window buffer
nnoremap <leader>n :bnext<CR>
nnoremap <leader>p :bprevious<CR>
"nnoremap <leader><Tab> :bnext<CR>
"nnoremap <leader><space><Tab> :bprevious<CR>
"change tab
nnoremap <leader>N gt
nnoremap <leader>P gT
nnoremap <leader>C :tabedit<CR>

" unmap the ctl-i (donno when does it it mapped to sth else)
"unmap <C-I>
"
"
"ycm related
"let g:ycm_global_ycm_exta_config= "~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
let g:ycm_confirm_extra_conf = 0
let g:syntastic_always_populate_loc_list = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_synatx = 1
"ycm debug
"let g:ycm_server_use_vim_stdout = 1
let g:ycm_server_log_level = 'debug'
"ycm jump to definition
nnoremap <leader>jd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>jD :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>ji :YcmCompleter GoToInclude<CR>

"set tag file
set tags+=./.tags

let g:ackprg="ack -s -H --nocolor --nogroup --column --type-add tags:is:tags --type=notags"

"enable the command dispaly
set showcmd

"Add for tmux window movement
"if exists('$tmux')
  "function! TmuxOrSplitSwitch(wincmd, tmuxdir)
    "let previous_winnr = winnr()
    "silent! execute "wincmd " . a:wincmd
    "if previous_winnr == winnr()
      "call system("tmux select-pane -" . a:tmuxdir)
      "redraw!
    "endif
  "endfunction
"
  "let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
  "let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
  "let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te
"
  "nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
  "nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
  "nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
  "nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
"else
  "map <C-h> <C-w>h
  "map <C-j> <C-w>j
  "map <C-k> <C-w>k
  "map <C-l> <C-w>l
"endif

" disable the wrap
set nowrap

"quick close file
nnoremap Q :q!
nnoremap QQ :qa!

"tagbar / taglist
nnoremap <leader>t :TagbarToggle<CR>
nnoremap <leader>tf :TagbarOpen jf<CR>:TagbarTogglePause<CR>
nnoremap <leader>l :TlistToggle<CR>

"add lines below or above and return to normal mode
nnoremap <leader>o o<ESC>k
nnoremap <leader>O O<ESC>j

"highlight the cursor line
"hi CursorLine   cterm=NONE ctermbg=black ctermfg=white guibg=darkred guifg=white
"highlight CursorLine   cterm=NONE ctermbg=DarkBlue

"set the line trailing characters
"set listchars=trail:·,precedes:«,extends:»,eol:↲,tab:▸\
"set list

"disbale goldenview mapping
let g:goldenview__enable_default_mapping = 0
"change easy motion prefix to single leader
map <Leader> <Plug>(easymotion-prefix)

" set the history to 10000
set history=10000

" Pyclewn PDB key mapping
"start the debuger
:nnoremap <F12> :exe "Pyclewn pdb ". expand("%p") <CR>
"stop the dbuger
:nnoremap <F11> :exe "Cexitclewn" <CR>
"set the break point for current line
:nnoremap <F5> :exe "Cbreak " . expand("%:p") . ":" . line(".")<CR>
"print the variable under cursor
:nnoremap <F6> :exe "Cpp " . expand("<cword>") <CR>
:nnoremap <F7> :exe "Cpp " . expand("<cWORD>") <CR>
"step
:nnoremap <F8> :exe "Cstep" <CR>
"Next
:nnoremap <F9> :exe "Cnext" <CR>
"continue
:nnoremap <F10> :exe "Ccontinue" <CR>

"enable the CamelCase Movement
call camelcasemotion#CreateMotionMappings('')

set wrap
"toggle the line number
map <leader>L :set number!<CR>:set relativenumber!<CR>
map <leader>l :set number!<CR>

"set the search under selection
vnoremap // y/<C-R>"<CR>

"set line limit to 79
set tw=99

"map s to <leader>s for easymotion
map s <leader>s
