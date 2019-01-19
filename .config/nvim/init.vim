" C/C++用のLLVM
let g:llvm_root = $LLVM_ROOT
if !strlen($LLVM_ROOT)
    autocmd FileType c call deoplete#disable()
endif

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
" colorscheme molokai
set background=dark
colorscheme hybrid

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

" SMBでnofsync
if system("pwd")[:7] == "/Volumes"
    set nofsync
endif

"leader を spaceに
let mapleader = "\<Space>"


" スニペットの設定
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"


" バッファ設定
nnoremap <silent> <C-j> :bprev<CR>
nnoremap <silent> <C-k> :bnext<CR>

" ノーマルモードに戻ったときにペーストモード解除
autocmd InsertLeave * set nopaste


" 補完にどのpythonを使うか設定
" anacondaの状態やvenvの状態によって変わる
" $CONDAROOTはanacondaのインストール先のディレクトリ
" $VIRTUAL_ENVはvenvのディレクトリ
" 優先順位 venv > condaenv > conda > system
if $CONDA_ROOT
    let g:python3_host_prog = $CONDA_ROOT/bin/python
elseif $CONDA_PREFIX
    let g:python3_host_prog = $CONDA_PREFIX/bin/python
elseif $VIRTUAL_ENV
    let g:python3_host_prog = $VIRTUAL_ENV/bin/python
endif

" マルチカーソルの時にdepleteを無効化
function g:Multiple_cursors_before()
    call deoplete#custom#buffer_option('auto_complete', v:false)
    if exists(':NeoCompleteLock')==2
	exe 'NeoCompleteLock'
    endif
endfunction
function g:Multiple_cursors_after()
    call deoplete#custom#buffer_option('auto_complete', v:true)
    if exists(':NeoCompleteUnlock')==2
	exe 'NeoCompleteUnlock'
    endif
endfunction

" BlockDiffのカーソルから2行やるやつ
function! Getblock2lines()
    call BlockDiff_GetBlock1()
    "yy"
    call cursor(line(".") + 1, '.')
    call BlockDiff_GetBlock2()
endfunction
nnoremap <Leader>b :call Getblock2lines()<CR>
nnoremap <Leader>q :execute ":tabclose"<CR>

" 範囲拡大
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" diffcharの設定
let g:DiffUnit = 'Char' " any single character
let g:DiffColors = 3 " 16 colors in fixed order
