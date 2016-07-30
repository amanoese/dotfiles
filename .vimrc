" vimrc に以下のように追記

" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
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

"scriptencoding utf-8
set background=dark
set nocompatible
set number

if has("win32")
	set backupdir=C:\Users\68650048\.vim\vimBackUp
	set directory=C:\Users\68650048\.vim\vimSwap
	set encoding=cp932
	set fileencodings=utf-8,euc-jp,iso-2022-jp,cp932,default,latin,ucs-bom,unicode
	" メニューバー非表示
	set guioptions=g
	set guioptions-=T
	" ステータスラインの表示
	set laststatus=2 
	" windowHigth
	set lines=9999
	" windowWidth
	set columns=9999
elseif has("unix") || has("win32unix") && has("job") 
	set backupdir=~/.vim/vimBackUp
	set directory=~/.vim/vimSwap
	set fileencodings=utf-8,euc-jp,iso-2022-jp,cp932,default,latin,ucs-bom,unicode
	set fileformat=unix
	"has vim に書かないとホントはNGぽいけど環境依存はげしそうなので?
	"http://stackoverflow.com/questions/5698284/in-my-vimrc-how-can-i-check-for-the-existence-of-a-color-scheme
	"{rtp}/autoload/has.vim
	function Colorscheme(name)
		let pat = 'colors/'.a:name.'.vim'
		return !empty(globpath(&rtp, pat))
	endfunction
elseif has("win32unix")
	set backupdir=/cygdrive/c/Users/68650048/.vim/vimBackUp
	set directory=/cygdrive/c/Users/68650048/.vim/vimSwap
	set fileencodings=utf-8,euc-jp,iso-2022-jp,cp932,default,latin,ucs-bom,unicode
	set fileformat=dos
endif
"set background=light
	"cd c:\taka\local\Vim\

set swapfile
let g:tlist_javascript_settings = 'javascript;c:class;m:method;f:function;p:property'


" fugit setting
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

set tags=tags
" font設定
set guifont=Myrica_M:h12
set guifontwide=Myrica_M:h12
"set guifont=ゆたぽん（コーディング）:h11
"set guifontwide=ゆたぽん（コーディング）:h11
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
command! Iplog tab new | e C:\taka\local\IPmsg\ipmsg201409-.log | e ++enc=utf-8


" 半透明にするやつdll無いと動作はしないです。
"if executable("vimtweak.dll")
"	autocmd guienter * call libcallnr("vimtweak","SetAlpha",220)
"	"↓はバツボタンとかの場所消す
"	"autocmd guienter * call libcallnr("vimtweak.dll", "EnableCaption", 0)
"endif


" vim-indent-guides
let g:indent_guides_guide_size=1

" eslint setting for synatic
let g:syntastic_check_on_open=0 "ファイルを開いたときはチェックしない
let g:syntastic_check_on_save=1 "保存時にはチェック
let g:syntastic_check_on_wq = 0 " wqではチェックしない
let g:syntastic_auto_loc_list=1 "エラーがあったら自動でロケーションリストを開く
let g:syntastic_loc_list_height=6 "エラー表示ウィンドウの高さ
set statusline+=%#warningmsg# "エラーメッセージの書式
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_javascript_checkers = ['eslint'] "ESLintを使う
let g:syntastic_mode_map = {
      \ 'mode': 'active',
      \ 'active_filetypes': ['javascript'],
      \ 'passive_filetypes': []
      \ }


" tagbar ?
nmap <F8> :TagbarToggle<CR>
nmap <kPlus> <C-a>
nmap <kMinus> <C-x>


" 読み込んだプラグインも含め、ファイルタイプの検出、ファイルタイプ別プラグイン/インデントを有効化する
filetype plugin indent on

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

" neocomplcache setteing
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplcache_enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplcache_enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_force_omni_patterns')
  let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplcache_force_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

"excel.vim setting code
"let g:zipPlugin_ext = '*.zip,*.jar,*.xpi,*.ja,*.war,*.ear,*.celzip,*.oxt,*.kmz,*.wsz,*.xap,*.docx,*.docm,*.dotx,*.dotm,*.potx,*.potm,*.ppsx,*.ppsm,*.pptx,*.pptm,*.ppam,*.sldx,*.thmx,*.crtx,*.vdw,*.glox,*.gcsx,*.gqsx'

"let let g:syntastic_mode_map = {"mode":"active","active_filetypes":["javascript", "json"]}

" Ctrl+Vの挙動を変更
nmap <C-v> <C-v>
cmap <C-v> <C-v>
" Ctrl+Aの挙動を変更
nmap <C-;> <C-a>
cmap <C-a> <C-a>
