scriptencoding utf-8


" 読み込んだプラグインも含め、ファイルタイプの検出、ファイルタイプ別プラグイン/インデントを有効化する
filetype off

if !&compatible
  set nocompatible
endif

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif

  if has("win32")
    execute 'set runtimepath^=' . substitute(fnamemodify(s:dein_repo_dir, ':p'),'\\$','','g')
  else
    execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
  endif
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイル（後述）を用意しておく
  let g:rc_dir    = expand('~/.dotfiles/deinrc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

filetype on
syntax on

"set background=light
	"cd c:\taka\local\Vim\

set background=dark
set nocompatible
set number
"set backupdir=$HOME/.vim/vimBackUp
"set directory=$HOME/.vim/vimSwap
set fileencodings=utf-8,euc-jp,iso-2022-jp,cp932,default,latin,ucs-bom,unicode

if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window (for an alternative on Windows, see simalt below).
  set lines=999 columns=999
endif

if has("win32") || has("win64") 
	"set encoding=cp932
	" メニューバー非表示
	set guioptions=g
	set guioptions-=T
	" ステータスラインの表示
	set laststatus=2 
	set transparency=230
	autocmd GUIEnter * set transparency=230
	" font設定
	set guifont=Myrica_M:h12:cSHIFTJIS:qDRAFT
	"set guifont=MyricaM:h12:cSHIFTJIS:qDRAFT
	"set guifont=ゆたぽん（コーディング）:h11
elseif has("unix") || has("win32unix") && has("job") 
	set fileformat=unix
elseif has("win32unix")
	set fileformat=dos
endif

let g:tlist_javascript_settings = 'javascript;c:class;m:method;f:function;p:property'


" fugit setting
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

set tags=tags
" タブを表示するときの幅
set tabstop=4
" タブを挿入するときの幅
set shiftwidth=4
" 自動改行させない
set tw=0
" 画面端で改行させない
set nowrap

" netrw setting http://blog.tojiru.net/article/234400966.html
" netrwは常にtree view
let g:netrw_liststyle = 3
" 'v'でファイルを開くときは右側に開く。(デフォルトが左側なので入れ替え)
let g:netrw_altv = 1
" 'o'でファイルを開くときは下側に開く。(デフォルトが上側なので入れ替え)
let g:netrw_alto = 1


" VBA 用設定
" vbac https://github.com/vbaidiot/Ariawase
function! Root_git()
	return system('git rev-parse --show-toplevel')
endfunction

function! Vbac_vim(str)
	let wsf_directory = matchstr(Root_git(),'[^\n]*') . '/vbac.wsf'
	if !executable(wsf_directory) 
		echo 'vbac.wsf file not found'
		return
	endif
	if a:str == 'Vread'
		echo system('cscript ' . wsf_directory . ' decombine')
	elseif a:str == 'Vwrite'
		echo system('cscript ' . wsf_directory . ' combine')
	endif
	return
endfunction

command! Vread call Vbac_vim('Vread')
command! Vwrite call Vbac_vim('Vwrite')

command! Tabex tab sp | Ve | only


" 半透明にするやつdll無いと動作はしないです。
"if executable("vimtweak.dll")
"	autocmd guienter * call libcallnr("vimtweak","SetAlpha",220)
"	"↓はバツボタンとかの場所消す
"	"autocmd guienter * call libcallnr("vimtweak.dll", "EnableCaption", 0)
"endif


" vim-indent-guides

" 読み込んだプラグインも含め、ファイルタイプの検出、ファイルタイプ別プラグイン/インデントを有効化する
"filetype plugin indent on

"set diffexpr=MyDiff()
"function! MyDiff()
"	let opt = '-a --binary '
"	if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
"	if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
"	let arg1 = v:fname_in
"	if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
"	let arg2 = v:fname_new
"	if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
"	let arg3 = v:fname_out
"	if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
"	let eq = ''
"	if $VIMRUNTIME =~ ' '
"		if &sh =~ '\<cmd'
"			let cmd = '""' . $VIMRUNTIME . '\diff"'
"			let eq = '"'
"		else
"			let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
"		endif
"	else
"		let cmd = $VIMRUNTIME . '\diff'
"	endif
"	silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
"endfunction

" Ctrl+Vの挙動を変更
nmap <C-v> <C-v>
cmap <C-v> <C-v>
" Ctrl+Aの挙動を変更
nmap <C-;> <C-a>
cmap <C-a> <C-a>
