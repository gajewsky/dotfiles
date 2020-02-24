call plug#begin('~/.vim/plugged')
  Plug 'takac/vim-hardtime'
  " Ruby
  Plug 'vim-ruby/vim-ruby'
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-endwise'
  Plug 'AndrewRadev/splitjoin.vim'

  " JavaScript
  Plug 'pangloss/vim-javascript'

  " Git
  Plug 'tpope/vim-git'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'                                          " Open GitHub source with :Gbrowse
  Plug 'airblade/vim-gitgutter'                                     " Show a diff using Vim its sign column
  Plug 'junegunn/gv.vim'                                            " A git commit browser
  Plug 'danishprakash/vim-githubinator'                             " Show selected text in Vim on Github

  " Syntax highlighting
  Plug 'Chiel92/vim-autoformat'
  Plug 'sheerun/vim-polyglot'                                       " Add syntax highlighting for a large range of filetypes
  Plug 'alcesleo/vim-uppercase-sql'

  " Visual
  Plug 'brooth/far.vim'
  Plug 'mhinz/vim-grepper'
  Plug 'elzr/vim-json', {'for': 'json'}                             " Better syntax highlighting for JSON files
  Plug 'morhetz/gruvbox'                                            " Gruvbox colorscheme
  Plug 'edkolev/tmuxline.vim'
  Plug 'itchyny/lightline.vim'                                      " Lightweight statusline without slow plugin integrations
  Plug 'shinchu/lightline-gruvbox.vim'
  Plug 'ryanoasis/vim-devicons'                                     " For file icons in lots of plugins
  Plug 'ap/vim-css-color'

  " Behaviour/tools
  Plug 'romainl/vim-qf'                                             " Automatically close quickfix windows that become orphaned
  Plug 'tpope/vim-repeat'                                           " Add repeat support with '.' for lots of plugins
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-rsi'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-speeddating'
  Plug 'AaronLasseigne/yank-code'

  " File Navigation
  Plug 'cskeeters/vim-smooth-scroll'                                " Smooth scroll animation instead of jump
  Plug 'christoomey/vim-tmux-navigator'                             " Navigate between tmux and vim with <C>+jkhl
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Fuzzy file++ searching
  Plug 'junegunn/fzf.vim'                                           " Asynchronous file/tags searcher
  Plug 'yuki-ycino/fzf-preview.vim'
  Plug 'justinmk/vim-dirvish'                                       " Directory viewer for Vim
  Plug 'kristijanhusak/vim-dirvish-git'
  Plug 'bogado/file-line'                                           " Open a file in a given line
  Plug 'unblevable/quick-scope'                                     " Lightning fast left-right movement in Vim
  Plug 'w0rp/ale'
  Plug 'pbrisbin/vim-mkdir'
  Plug 'justincampbell/vim-eighties'                                " Automatically resizes your windows
  Plug 'junegunn/vim-easy-align'
  Plug 'rstacruz/vim-closer'
  Plug 'mileszs/ack.vim'
  Plug 'justinmk/vim-sneak'
  Plug 'Shougo/neomru.vim'

call plug#end()

" ================ General Config ====================
"
set shell=/usr/bin/bash
set nocompatible
set gdefault
set timeout timeoutlen=1000
let mapleader=","
syntax on
runtime macros/matchit.vim
set mouse=a

 " ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Search ===========================

set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

filetype plugin indent on
filetype plugin on
filetype indent on

set list listchars=tab:\ \ ,trail:· "Display tabs and trailing spaces visually
set linebreak "Wrap lines at convenient points

" ================ FZF ===============================
source $HOME/.config/nvim/fzf.vim

" ================ Theme =============================

set termguicolors
set number
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set background=dark
let g:gruvbox_terminal_colors = 1
colo gruvbox

let g:powerline_loaded = 1
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ }

let &colorcolumn="99".join(range(99,999),",") "Ruller
set list listchars=tab:»·,trail:· " Display extra whitespace
let g:eighties_enabled = 1
let g:eighties_minimum_width = 99

" let terminal resize scale the internal windows
autocmd VimResized * :wincmd =

" Use arrow keys to resize windows
noremap <up>    <C-W>+
noremap <down>  <C-W>-
noremap <left>  3<C-W><
noremap <right> 3<C-W>>

set splitbelow        " new hoz splits go below
set splitright        " new vert splits go right

" prefer vertical orientation when using :diffsplit
set diffopt+=vertical

" quick-scope - trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" ================ Git ===============================
" Update sign column every quarter second
" set updatetime=250

" Use fontawesome icons as signs
let g:gitgutter_sign_added = ''
let g:gitgutter_sign_modified = ''
let g:gitgutter_sign_removed = ''
let g:gitgutter_sign_removed_first_line = ''
let g:gitgutter_sign_modified_removed = ''

" Jump between hunks
nmap <Leader>gn <Plug>GitGutterNextHunk
nmap <Leader>gp <Plug>GitGutterPrevHunk

" Hunk-add and hunk-revert for chunk staging
nmap <Leader>ga <Plug>GitGutterStageHunk  " git add (chunk)
nmap <Leader>gu <Plug>GitGutterUndoHunk   " git undo (chunk)

" Open current line in the browser
nnoremap <Leader>gb :.Gbrowse<CR>

" Open visual selection in the browser
vnoremap <Leader>gb :Gbrowse<CR>


" ================ Navigation ========================

nmap ga <Plug>(EasyAlign)

noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <ESC>:update<CR>l

map <C-t> <esc>:tabnew<CR>

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

noremap H ^
noremap L $

" Re-select visual block after indenting
vnoremap < <gv
vnoremap > >gv

" Keep search matches in the middle of the screen
nnoremap n nzz
nnoremap N Nzz

nmap <Leader><Space> :nohl<cr>

" " go substitute because the default map for sleeping is silly
nnoremap gs :%s//<Left>

nnoremap <leader>: "xyiw:%s/<C-R>x/gc

nnoremap <NL> i<CR><ESC>

" Highlight merge conflict markers
match Todo '\v^(\<|\=|\>){7}([^=].+)?$'

noremap <silent> k gk
noremap <silent> j gj
noremap <silent> 0 g0
noremap <silent> $ g$

if executable('rg')
  let g:ackprg = 'rg --vimgrep'
endif

" ================ Neovim ============================

set inccommand=split

if has('nvim')
  tnoremap <Esc> <C-\><C-n>
endif

" ================ Functions =========================

" Automatically strip whitespaces
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  let _s=@/
  call cursor(l, c)
  let @/=_s
endfun
autocmd BufWritePre *.* :call <SID>StripTrailingWhitespaces()

" ================ Neovim ============================

set inccommand=split

if has('nvim')
  tnoremap <Esc> <C-\><C-n>
endif

" ================ Functions =========================

" Automatically strip whitespaces
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  let _s=@/
  call cursor(l, c)
  let @/=_s
endfun
autocmd BufWritePre *.* :call <SID>StripTrailingWhitespaces()

