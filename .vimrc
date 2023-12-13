so ~/.vim/plugins.vim

set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//
set nocompatible              " be iMproved, required

"colors
set t_Co=256
set background=dark
set termguicolors

"syntax highlighting
syntax enable
filetype plugin indent on

"Leader Shortcuts
let g:mapleader=","
inoremap jk <esc> 

"split navigations
set splitbelow 
set splitright
set laststatus=2
nnoremap <C-T> :vsp 
nnoremap <C-D> :sp 
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"Plugin shortcuts
nnoremap <C-;> :FZF<cr>
nnoremap <C-U> :UndotreeToggle<cr>
nnoremap <C-O> :NERDTreeToggle<cr>

"set pastetoggle=<C-P>

nnoremap <leader>l :set list!<CR>
set listchars=tab:▸\ ,eol:¬

"UTF8 Support
set encoding=utf-8

"UI Config
set number              "show line numbers 
set relativenumber
set numberwidth=2
set showcmd             "show commandin bottom bar
set cursorline          "highlight current line
set wildmenu            "visual autocomplete for command menu
set lazyredraw          "redraw only when we need to
set showmatch           "highlight matching parentheses
set list
hi LineNr ctermfg=244   "numbers are grey

"Spaces and Tabs
set expandtab
set tabstop=2
set shiftwidth=2
set noexpandtab

"Folding
set foldenable          "enable folding
set foldlevelstart=10   "open most folds by default
set foldnestmax=10      "10 nested fold max
nnoremap <space> za
set foldmethod=indent   "fold based on indent level

let g:lightline = {
  \   'colorscheme': 'palenight', 
  \   'active': {
  \     'left': [['mode', 'paste' ], ['readonly', 'filename', 'modified']],
  \     'right': [['lineinfo'], ['percent'], ['fileformat', 'fileencoding']]
  \   }
  \ }

let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
