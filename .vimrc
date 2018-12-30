set rnu
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
set nowrap

set backup
set undofile
set undodir=~/.vim/.tmp/undo/
set backupdir=~/.vim/.tmp/bkp/
set directory=~/.vim/.tmp/dir/

set autowrite
set showcmd

" automatically change the working directory
set autochdir

" no errorbells visualbell
set noeb vb t_vb=
set laststatus=2

set wildmenu
set wildmode=longest,full
set foldmethod=indent
set diffopt=foldcolumn:0,iwhite,filler
set nofoldenable

set hlsearch
hi clear search
hi link search IncSearch

" keeping the backspace button to remove chars in insert mode
set backspace=indent,eol,start

set ignorecase
set smartcase


set timeoutlen=1000
set ttimeoutlen=0

let mapleader = ","
let maplocalleader = ","

syntax on
syntax enable
filetype plugin indent on

set wildignore=*.dll,*.exe,.git,node_modules,bin,*.class,target,*.idea,*.settings
set wildignore+=*.classpath,*.project,*.ipr,*.iws,*.stackdump,*.pdf,*.docx,*.xlsx
set wildignore+=*.so,*.a,*.zip,*.7z

ino jk <C-n>
ino jj <Esc>l

" deleting without storing to the registry
nn <leader>d "_d
nn <leader>x "_x
vn <leader>d "_d

" copy
vn <leader>c "+y

" paste
cmap <C-v> <C-r>+
ino <C-c> <C-r>+
nn <leader>v "+p

nn <C-j> :tabprev<CR>
nn <C-k> :tabnext<CR>

" Setting spell check for n/i/v modes
nn <F6> :setlocal spell! spell?<cr>
ino <F6> <Esc> :setlocal spell! spell?<cr>i
vn <F6> <Esc> :setlocal spell! spell?<cr>gv

" Write sudo files
nn <leader>w :w !sudo tee > /dev/null %<cr>

" execute python and cpp code
autocmd filetype python nn <buffer> <leader>r :exec '!clear; python' shellescape(@%,1)<cr>
autocmd filetype cpp nn <buffer> <leader>r :exec '!clear; g++ -std=c++14 -02 -Wall -pedandic -pthread -o out % && ./out' shellescape(@%,1)<cr>

" Markdown key map; *.md treats as markdown file

autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd FileType markdown nn <C-K> viW<esc>hbi`<esc>lel
autocmd FileType markdown ino <C-K> ``<Esc>i
autocmd FileType markdown vn <C-K> <Esc>`<i`<Esc>`>ea`<Esc>gv

" for vimdiff better color
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=34 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText cterm=bold ctermfg=10 ctermbg=34 gui=none guifg=bg guibg=Red


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""" Plugings """"""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if empty(glob('~/.vim'))
    silent !mkdir -p ~/.vim/.tmp/{undo,bkp,dir}
    silent !curl --insecure -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/plugged')

Plug('jiangmiao/auto-pairs')
Plug('tpope/vim-commentary')
Plug('tpope/vim-surround')
Plug('vim-airline/vim-airline')
Plug('junegunn/vim-easy-align')
Plug('leafgarland/typescript-vim')
Plug('scrooloose/nerdtree')
Plug('tpope/vim-fugitive')
Plug('kien/ctrlp.vim')
Plug('tpope/vim-repeat')
Plug('vimwiki/vimwiki')
Plug('shime/vim-livedown')

call plug#end()

if has('gui_running')
    set guioptions=
    set guifont=Consolas:h12:cANSI
    set lines=40 columns=120
    colorscheme solarized
    "set the visual bell disable in gui mode
    autocmd GUIEnter * set vb t_vb=
else "This is to make the cursor shape change when changing the mode
    let &t_SI = "\<Esc>[5 q"
    let &t_SR = "\<Esc>[3 q"
    let &t_EI = "\<Esc>[ q"
endif

nmap <leader>n :NERDTreeToggle<CR>

let g:jsx_ext_required = 0
" vimwiki/vimwiki
let g:vimwiki_list = [{'path': '~/notes/personal', 'syntax': 'markdown', 'ext': '.md'}]
