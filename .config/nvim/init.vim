if &compatible
  set nocompatible
endif

" # dein.vimインストール時に指定したディレクトリをセット
let s:dein_dir = expand('~/.cache/dein')

" # dein.vimの実体があるディレクトリをセット
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vimが存在していない場合はgithubからclone
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " # dein.toml, dein_layz.tomlファイルのディレクトリをセット
  let s:toml_dir = expand('~/.config/nvim')

  " # 起動時に読み込むプラグイン群
  call dein#load_toml(s:toml_dir . '/dein.toml', {'lazy': 0})

  " # 遅延読み込みしたいプラグイン群
  call dein#load_toml(s:toml_dir . '/dein_lazy.toml', {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif


" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif



" vimの設定
colorscheme molokai
filetype plugin indent on
syntax enable
let mapleader = "\<Space>"
": と ; 入れ替え
nnoremap ; :
nnoremap : ;
"jjでエスケープ
inoremap <silent> jj <ESC>
set backspace=indent,eol,start
set number

set shiftwidth=4
set autoindent
set smartindent
set mouse=a
set whichwrap=b,s,h,l,<,>,[,]
" set ttymouse=xterm2

"Ctrl-rファイル名補完
inoremap <C-r> <C-x><C-f>

set ttyfast
set t_Co=256

set list
set listchars=tab:>-,extends:<,trail:-,eol:<
set cursorline

syntax on
filetype plugin on
filetype indent on

"検索関係
set hlsearch "検索結果をハイライト
"ESC2回でハイライトを消す
nnoremap <ESC><ESC> :noh<CR>

" クリップボード共有
set clipboard+=unnamed

"quickrunの設定
nnoremap <C-i> "i:QuickRun -outputter/buffer/split ":botright"<CR>"

" NERDTree
nnoremap <silent><C-e> :NERDTreeToggle<CR>
let NERDTreeShowHidden = 1

let $PATH = "~/.pyenv/shims:".$PATH

" 常に補完開始
let g:deoplete#enable_at_startup = 1

" tabキーで補完順が逆になるのを修復、jediで窓が出るのを阻止
let g:SuperTabContextDefaultCompletionType = "context"
let g:SuperTabDefaultCompletionType = "<c-n>"
autocmd FileType python setlocal completeopt-=preview


" vimprocで非同期実行
" 成功時にバッファ、失敗時にQuickFixで表示
" 結果表示のサイズ調整など
let g:quickrun_config = {
    \ '_' : {
        \ 'runner' : 'vimproc',
        \ 'runner/vimproc/updatetime' : 40,
        \ 'outputter' : 'error',
        \ 'outputter/error/success' : 'buffer',
        \ 'outputter/error/error'   : 'quickfix',
        \ 'outputter/buffer/split' : ':botright 8sp',
    \ }
\}

" 実行時に前回の表示内容をクローズ&保存してから実行
let g:quickrun_no_default_key_mappings = 1
nnoremap <silent><C-r> :cclose<CR>:write<CR>:QuickRun -mode n<CR>

" 表示位置保存
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END
