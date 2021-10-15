call plug#begin('~/.vim/plugged')
  Plug 'morhetz/gruvbox'      " Gruvbox colorscheme
  Plug 'kyazdani42/nvim-web-devicons'

  " telescope
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  Plug 'kyazdani42/nvim-tree.lua' "File navigation

  " ruby
  Plug 'vim-ruby/vim-ruby'
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-endwise'
  Plug 'AndrewRadev/splitjoin.vim'

  Plug 'christoomey/vim-tmux-navigator'                             " Navigate between tmux and vim with <C>+jkhl
  Plug 'justincampbell/vim-eighties'                                " Automatically resizes your windows
call plug#end()

" ================ General Config ====================


"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

"" Fix backspace indent
set backspace=indent,eol,start

"" Enable hidden buffers
set hidden
set shell=/usr/bin/bash
set nocompatible
set gdefault
set timeout timeoutlen=1000
let mapleader=","
let maplocalleader = "\\"
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

" ================ telescope =========================

nnoremap <leader>f <cmd>lua require('telescope.builtin').find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!{.git,sorbet}'}})<cr>
nnoremap <leader>F <cmd>lua require('telescope.builtin').git_files({ find_command = {'rg', '--files', '--hidden', '-g', '!{.git,sorbet}' }})<cr>
nnoremap <leader>l <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>b <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>h <cmd>lua require('telescope.builtin').help_tags()<cr>

" ================ nvim-tree =========================

nnoremap \ :NvimTreeToggle<CR>

" ================ Theme =============================

set termguicolors
set number
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set background=dark
let g:gruvbox_terminal_colors = 1
colo gruvbox

let g:powerline_loaded = 1
let g:lightline = { 'colorscheme': 'gruvbox' }

colorscheme gruvbox

let &colorcolumn="99".join(range(99,999),",") "Ruller
set list listchars=tab:»·,trail:· " Display extra whitespace
let g:eighties_enabled = 1
let g:eighties_minimum_width = 100

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

" ================ Plugins settings ==================
" Update sign column every quarter second
" set updatetime=250

" Use fontawesome icons as signs
let g:gitgutter_sign_added = ''
let g:gitgutter_sign_modified = ''
let g:gitgutter_sign_removed = ''
let g:gitgutter_sign_removed_first_line = ''
let g:gitgutter_sign_modified_removed = ''

" let g:deoplete#enable_at_startup = 1
set completeopt-=preview

let g:float_preview#docked = 0
let g:float_preview#max_width = 80
let g:float_preview#max_height = 40

let g:rainbow_active = 1

let g:sexp_enable_insert_mode_mappings = 0

" Jump between hunks
nmap <Leader>gn <Plug>GitGutterNextHunk
nmap <Leader>gp <Plug>GitGutterPrevHunk

" Hunk-add and hunk-revert for chunk staging
nmap <Leader>ga <Plug>GitGutterStageHunk  " git add (chunk)
nmap <Leader>gu <Plug>GitGutterUndoHunk   " git undo (chunk)

" Open current line in the browser
nnoremap <Leader>gb :.Gbrowse<CR>

nnoremap <leader>p "0p
nnoremap <leader>P "0P

set wildcharm=<c-z>
cnoremap <expr> <Tab>   getcmdtype() =~ '[?/]' ? "<c-g>": "<c-z>"
cnoremap <expr> <S-Tab> getcmdtype() =~ '[?/]' ? "<c-t>" : "<S-Tab>"

" Open visual selection in the browser
vnoremap <Leader>gb :Gbrowse<CR>
" <Leader>f{char} to move to {char}
map  <Leader>m <Plug>(easymotion-bd-f)
nmap <Leader>m <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

nnoremap <Leader>o :ToggleOnly<Enter>

" ================ Navigation ========================
"
"
" visual mode:
xnoremap <c-j> 10j
xnoremap <c-k> 10k
nmap ga <Plug>(EasyAlign)

noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <ESC>:update<CR>l

map <C-t> <esc>:tabnew<CR>

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
" vnoremap K :m '<-2<CR>gv=gv

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
nnoremap gs :%s/<c-r><c-w>//gc<Left><Left><Left>


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

nnoremap cv :e $MYVIMRC<CR>

" Easier way to go to normal mode. Also, alternative to <ESC>.
noremap! <silent> <C-l> <ESC>
vnoremap <silent> <C-l> <ESC>
onoremap <silent> <C-l> <ESC>

noremap <Space> :

" Enable vim-iced's default key mapping
let g:iced_enable_default_key_mappings = v:true

let g:ale_sign_error = "◉"
let g:ale_sign_warning = "◉"

"*****************************************************************************
""" Abbreviations
""*****************************************************************************
""" no one is really happy until you have this shortcuts
"cnoreabbrev W! w!
"cnoreabbrev Q! q!
"cnoreabbrev Qall! qall!
"cnoreabbrev Wq wq
"cnoreabbrev Wa wa
"cnoreabbrev wQ wq
"cnoreabbrev WQ wq
"cnoreabbrev W w
"cnoreabbrev Q q
"cnoreabbrev Qall qall


""" Split
"noremap <Leader>h :<C-u>split<CR>
"noremap <Leader>v :<C-u>vsplit<CR>

""" Tabs
"nnoremap <Tab> gt
"nnoremap <S-Tab> gT
"nnoremap <silent> <S-t> :tabnew<CR>

" ================ Neovim ============================

set inccommand=split

if has('nvim')
  tnoremap <Esc> <C-\><C-n>
endif

" ================ Functions =========================

" Command to copy the current file's full absolute path.
command CopyFilePath let @+ = expand(has('win32') ? '%:p:gs?/?\\?' : '%:p')

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
