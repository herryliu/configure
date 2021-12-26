"-------------- VimPlug ---------------------------
" Plug plugin management

"set nocompatible              " be iMproved, required
"filetype off                  " required

" initialize vimplug by: curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" set the runtime path to include Vundle and initialize
"if empty(glob('~/.vim/autoload/plug.vim'))
"    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
"        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
"endif

call plug#begin('~/.vim/plugged')
" my plugin list
" -------- 1. Tmux and Vim Integration -------
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'roxma/vim-tmux-clipboard'

" ------- 2. Vim style and color ---------
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Wutzara/vim-materialtheme'
Plug 'altercation/vim-colors-solarized'

" ------ 3. Vim directory/file list/access -----
"Plug 'scrooloose/nerdtree'
"Plug 'kien/ctrlp.vim'
Plug 'qpkorr/vim-bufkill'

" ------ 4. Vim Soruce Code Tagging/Structure  --------
"Plug 'int3/vim-taglist-plus'
" Please download the universal ctag if the default one from debian producing
" errors. https://github.com/universal-ctags/ctags
"Plug 'majutsushi/tagbar'
Plug 'preservim/tagbar'
"Plug 'asford/tagselect'
Plug 'tpope/vim-fugitive'
Plug 'pseewald/vim-anyfold'
Plug 'nathanaelkane/vim-indent-guides'

" ------ 5. Vim Source Code Auto-completion -----
"Plug 'ervandew/supertab'
"Plug 'davidhalter/jedi-vim'
"Plug 'Valloric/YouCompleteMe'
Plug 'Shougo/neoinclude.vim'
Plug 'jsfaint/coc-neoinclude'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" ------ 6. Vim Source Code Editing -------
Plug 'tpope/vim-surround'
Plug 'ntpeters/vim-better-whitespace'
Plug 'Vimjas/vim-python-pep8-indent'
"Plug 'python-mode/python-mode'
Plug 'terryma/vim-multiple-cursors'
"Plug 'Raimondi/delimitMate'
"Plug 'jiangmiao/auto-pairs'
Plug 'honza/vim-snippets'
Plug 'fidian/hexmode'

" ------ 6.5 Vim Source Code Formating -------
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'

" ------ 6.6 Vim Source Code Debuging  -------
Plug 'szw/vim-maximizer'
Plug 'puremourning/vimspector'

" ------ 7. Vim Source Code Searching/Movement -------
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'bkad/CamelCaseMotion'
Plug 'mileszs/ack.vim'
Plug 'nelstrom/vim-visual-star-search'

" ------ 8. Others -----
Plug 'dhruvasagar/vim-table-mode'
Plug 'vimwiki/vimwiki'
Plug 'gyim/vim-boxdraw'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
"Plug 'airblade/vim-rooter'
Plug 'ncm2/float-preview.nvim'
Plug 'chrisbra/csv.vim'

" All of your Plugins must be added before the following line
" Initialize plugin system
call plug#end()
"--------------- End of VimPlug -----------------
"
"
"------------- System Wise Setting ------------
"set the shell
set shell=/bin/bash
let $TMPDIR=$HOME."/tmp"
let $BASH_ENV="~/.bash_aliases"

"auto reload the of .vimrc
autocmd! bufwritepost .vimrc source %

" Better copy and paste
set pastetoggle=<F2>

" backspace
set bs=2

let mapleader="\<Space>"

" quicksave
noremap <C-Z> :update<CR>
vnoremap <C-Z> <C-C>:update<CR>
inoremap <C-Z> <C-O>:update<CR>

"map <C-j> <C-w>j
"map <C-k> <C-w>k
"map <C-l> <C-w>l
"map <C-h> <C-w>h

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

" define space as leader key
let mapleader="\<Space>"

" change the window size
map <C-w><C-h> :vertical resize -5 <CR>
map <C-w><C-j> :resize +5<CR>
map <C-w><C-k> :resize -5<CR>
map <C-w><C-l> :vertical resize +5 <CR>

" clear the highlight
map <C-w>n :nohl<CR>

" set the history to 10000
set history=10000

"toggle the line number
"map <leader>L :set number!<CR>:set relativenumber!<CR>
map <leader>l :set number!<CR>

set linebreak

"window max and restore (ctrl-w-o / ctrl-w-u)
nnoremap <C-w>o :mksession! ~/session.vim<CR>:wincmd o<CR>
nnoremap <C-w>u :source ~/session.vim<CR>

" save/restore VIM session
map <F11> :mksession! ~/.vim_session <cr>
map <F12> :source ~/.vim_session <cr>

" set the folding to syntax and open all level
set foldmethod=syntax
set foldlevel=999

" cycle the window buffer
nnoremap <leader>n :bnext<CR>
nnoremap <leader>p :bprevious<CR>
"change tab
"nnoremap <leader>N gt
"nnoremap <leader>P gT
"nnoremap <leader>C :tabedit<CR>

"set tag file
set tags+=./.tags

"enable the command dispaly
set showcmd

" disable the wrap
set nowrap

"quick close file
nnoremap Q :q!
nnoremap QQ :qa!

"set hidden
set hidden

"toggle paste
map <leader>P :set paste!<CR>

" set search path for include files
set path=.,/usr/local/include,/usr/include

"------ End Of System wise setting --------

"======= Plugin Configuration ================
"
"========== 1. Tmux and Vim Integration ===========
"
"========== 2. Vim style and color ==============
"
"------- New Airline Related Settig -----------
" color scheme
set t_Co=256
syntax enable
if has('gui_running')
    set background=light
else
    set background=dark
endif
let g:solarized_termcolors=256
"let g:airline_powerline_fonts=1
let g:airline_theme = 'angr'
"let g:airline_theme = 'solarized'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
"let g:airline_symbols.crypt = '🔒'
"let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = '|'
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.maxlinenr = ''
"let g:airline_symbols.maxlinenr = '㏑'
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
"let g:airline_symbols.spell = 'Ꞩ'
"let g:airline_symbols.notexists = 'Ɇ'
"let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
"let g:airline_symbols.branch = ''
"let g:airline_symbols.readonly = ''
"let g:airline_symbols.linenr = '☰'
"let g:airline_symbols.maxlinenr = ''
"let g:airline_symbols.dirty='⚡'

" old vim-powerline symbols
"let g:airline_left_sep = '⮀'
"let g:airline_left_alt_sep = '⮁'
"let g:airline_right_sep = '⮂'
"let g:airline_right_alt_sep = '⮃'
"let g:airline_symbols.branch = '⭠'
"let g:airline_symbols.readonly = '⭤'
"let g:airline_symbols.linenr = '⭡'


" enable tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

"let g:airline#extensions#hunks#enabled =0

let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#eclim#enabled = 1


nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

" enable/disable showing a summary of changed hunks under source control. >
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#hunks#enabled = 1
" enable/disable showing only non-zero hunks. >
let g:airline#extensions#hunks#non_zero_only = 0
" set hunk count symbols. >
let g:airline#extensions#hunks#hunk_symbols = ['+', '~', '-']
" set filename
let g:airline_section_c = '%t'
let g:airline_section_c = airline#section#create(['%t', ' ', 'readonly'])

let g:airline_section_y = airline#section#create_right([hostname()])

" set default layout
let g:airline#extensions#default#layout = [
            \ [ 'a', 'b', 'c', ],
            \ [ 'x', 'y', 'z' ]
            \ ]

" control the auto-truncation of airline
let g:airline#extensions#default#section_truncate_width = {
            \ 'b': 79,
            \ 'x': 60,
            \ 'y': 88,
            \ 'z': 45,
            \ }
"let g:airline#extensions#default#section_truncate_width = {}

""""""""""tmuxline""""""""""""""""""""""
let g:airline#extensions#tmuxline#enabled = 0
let g:tmuxline_theme = 'airline_virtual'

let g:tmuxline_preset = {
            \'a'    : '#(whoami)',
            \'b'    : '#H',
            \'win'  : ['#I', '#W'],
            \'cwin' : ['#I', '#W', '#F'],
            \'z'    : '#(date)'}

"--------- end of New Airlein setting --------

"========  3. Vim directory/file list/access =====

"" ----- CtrlP Related Options ---------
" set the ctrl-p to follow the symlinks
let g:ctrlp_follow_symlinks = 1
" set the default mode to be serrach both buffer and file
"let g:ctrlp_cmd = 'CtrlPMixed'
" set to filename search by default
let g:ctrlp_by_filename = 1
"let g:ctrlp_max_files=0
"let g:ctrlp_max_depth=40
let g:ctrlp_match_window = 'results:100'
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
" ctrl-p allow same buffer open in save tab/different window
let g:ctrlp_switch_buffer = "t"

"========== 4. Vim Soruce Code Tagging/Structure ========

" --------------- Tagbar / TagList Related Optoins -------
""tagbar / taglist
let g:tagbar_ctags_bin='/usr/bin/ctags-universal'
nnoremap <leader>T :TagbarToggle<CR>
"nnoremap <leader>tf :TagbarOpen jf<CR>:TagbarTogglePause<CR>
"nnoremap <leader>tl :TlistToggle<CR>

"add lines below or above and return to normal mode
nnoremap <leader>o o<ESC>k
nnoremap <leader>O O<ESC>j

" ======== 5. Vim Source Code Auto-completion =========

" -------------- Supertab Related Options -------------
"change supertab moving direciton
let g:SuperTabDefaultCompletionType = "<c-n>"
" vim file name completion in insermode <c-x><x-f>

" -------------- Jedi Related Options -------------
" disable the autocomplete preview window
autocmd FileType python setlocal completeopt-=preview
" keep the <leader>n as next buffer (it was mapped to usage)
let g:jedi#usages_command = "<leader>u"
" set the autocompletion key to ctl-n
let g:jedi#completions_command = "<C-N>"
" disable the auto pop up
let g:jedi#popup_on_dot = 0
" disable call signature
let g:jedi#show_call_signatures = "0"
" pick the first one on list
let g:jedi#popup_select_first = 1

" ------ YCM Related Optoins ----------
"function YcmToggle()
"    if g:ycm_auto_trigger
"        let g:ycm_auto_trigger=0
"    else
"        let g:ycm_auto_trigger=1
"    endif
"endfunction
"
"nnoremap <leader>c :call YcmToggle()<CR>
"nnoremap <leader>ce :let g:ycm_auto_trigger=1<CR>
"nnoremap <leader>cd :let g:ycm_auto_trigger=0<CR>
"
"let g:ycm_global_ycm_exta_config= "~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
"let g:ycm_global_ycm_extra_conf='/scratch/herry/git/dev/.ycm_extra_conf.py'
"let g:ycm_confirm_extra_conf = 0
"let g:syntastic_always_populate_loc_list = 1
"let g:ycm_collect_identifiers_from_tags_files = 1
"let g:ycm_seed_identifiers_with_synatx = 1
"ycm debug
"let g:ycm_server_use_vim_stdout = 1
"let g:ycm_server_log_level = 'debug'
"ycm jump to definition

"------- End of YCM -----------

"======== 6. Vim Source Code Editing ===========

" -------------- Better-whitespace Related Optoins --------
"highlight ExtraWhitespace ctermbg=blue
let g:better_whitespace_guicolor='blue'
let g:better_whitespace_ctermcolor='blue'
"clear all end of line space
nnoremap <leader><Space> :StripWhitespace<CR>

" -------------- Python-mode Related Options ------------
"set pymode line max length
let g:pymode_options_max_line_length = 128

" ------------- Auto Pairs Related Options -------------
let g:AutoPairsShortcutToggle = '<leader>"'
let g:AutoPairsShortcutFastWrap = '<leader>e'

" ====== 6.6 Vim Source Code Debuging  =======
nnoremap <leader>m :MaximizerToggle<CR>

" ------- vimspector setting -----
let g:vimspector_enable_mappings = 'HUMAN'
nmap <leader>dd :call vimspector#Launch()<CR>
nmap <leader>dx :VimspectorReset<CR>
nmap <leader>de :VimspectorEval<space>
nmap <leader>dw :VimspectorWatch<space>
"nmap <leader>do <plug>VimspectorShowOutput
nmap <leader>db <plug>VimspectorToggleBreakpoint
nmap <leader>dc <plug>VimspectorContinue
nmap <leader>ds <plug>VimspectorStop
nmap <leader>dr <plug>VimspectorRestart
nmap <leader>dp <plug>VimspectorPause
nmap <leader>dc <plug>VimspectorRunToCursor
nmap <leader>dn <plug>VimspectorStepOver
nmap <leader>di <plug>VimspectorStepInto
nmap <leader>do <plug>VimspectorStepOutput

"====== 7. Vim Source Code Searching/Movement ========

" ---------------- Easymotion Related Options -----------
"change easy motion prefix to single leader
map <S-Enter> <Plug>(easymotion-prefix)
"map s <Plug>(easymotion-s)
map s <Plug>(easymotion-overwin-f)

" ------------ incsearch-easymotion Related Options -----
" insearch-easymotion
map z/ <Plug>(incsearch-easymotion-/)
map z? <Plug>(incsearch-easymotion-?)
map zg/ <Plug>(incsearch-easymotion-stay)

call camelcasemotion#CreateMotionMappings('')

" --------------------- ACK Related Option ---------
let g:ackprg="ag"
nnoremap <leader>S :Ack!<space>
"Ack search
map <leader>/ :Ack<space>
" ---------------- End Of ACK -----------

" ---------- 8. Others --------------

" ------ vimwiki ------
"  disable the Enter to follow the line (it's too easy to create page
"  accidentally)
nmap <leader>wf <Plug>VimwikiFollowLink

"
"-------- drawing ------
" allow selection go beyond end of line
"set virtualedit+=all

" ------------ VIM Yank To System Buffer By OSC52 ------------
function! Yank(text) abort
  let escape = system('yank', a:text)
  if v:shell_error
    echoerr escape
  else
    call writefile([escape], '/dev/tty', 'b')
  endif
endfunction

" -------- fzf -------
"set rtp+=/usr/bin/fzf
set rtp+=/home/admin/.linuxbrew/opt/fzf
noremap <silent> y y:<C-U>call Yank(@0)<CR>
"noremap <silent> <Leader>f :Files<CR>
" all file/buffer/buffer line /all lines search/open will be <space> + Upper
" case
" all lines search for all directories below uses the Ack!--> map in Ack ession --> <space>S
noremap <silent> <leader>F :Files<CR>
noremap <silent> <leader>L :Lines<CR>
noremap <silent> <leader>B :Buffers<CR>


"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" -------- color scheme ---------
colorscheme gruvbox
"colorscheme monokai

" -------- Coc setup ---------
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
"inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
"                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"inoremap <silent><expr> <CR> pumvisible() ? "\<C-y><CR>" : "\<CR>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" GoTo code navigation.
nmap gd <Plug>(coc-definition)
nmap gD <Plug>(coc-declaration)
nmap gi <Plug>(coc-implementation)
nmap gt <Plug>(coc-type-definition)
nmap gr <Plug>(coc-coc-references)
nmap gu <Plug>(coc-references-used)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

nnoremap <silent> <space>ce :CocEnable<CR>
nnoremap <silent> <space>cd :CocDisable<CR>

" -------- End of Coc setup ---------

" Setup tab size by filetype
autocmd Filetype css setlocal tabstop=2 shiftwidth=2
autocmd Filetype html setlocal tabstop=2 shiftwidth=2
autocmd Filetype python setlocal tabstop=4 shiftwidth=4

" disable the cursor shape change
set guicursor=
" dislable hightlight search
set nohlsearch

" edit mode double captial letter command
inoremap LL <Esc>lli
inoremap JJ <Esc>lji
inoremap KK <Esc>lki
inoremap HH <Esc>lhi
inoremap WW <Esc>lwi
inoremap EE <Esc>lea
inoremap BB <Esc>lbi
inoremap OO <Esc>o
inoremap DD <Esc>ldei
inoremap XX <Esc>lxi
inoremap AA <Esc>A
inoremap II <Esc>I
inoremap PP <Esc>lpi

" copy multiple data into regist a.
vnoremap YY "Ay
" clear register a
vnoremap <silent> Yc <ESC>:let @a=""<CR>
" paste the multi-selection
nnoremap <silent> PP "ap:let @a=""<CR>

" set the python3.8 for shsys2
" let g:python3_host_prog='/usr/local/bin/python3.8'
