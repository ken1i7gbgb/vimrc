"
" VIM settings
"
"============================================================
"  基本設定
"============================================================
"行番号を表示
set nu
"スワップファイルを作らない
set noswapfile
"バックアップファイルを作らない
set nobackup
".un~ファイルを作成しない
set noundofile
" タイトルをウィンドウ枠に表示する
set title

" タブをスペースとする
set expandtab
" タブ幅
set tabstop=4
" 挿入されるタブ幅
set shiftwidth=4
" Tabキー押し下げ時の挿入される空白の量，0の場合はtabstopと同じ
set softtabstop=0
" 現在の行を強調表示
set cursorline
" 現在の行を強調表示(縦)
set cursorcolumn

" Vimの自動コメント挿入をさせない
augroup auto_comment_off
    autocmd!
    autocmd BufEnter * setlocal formatoptions-=r
    autocmd BufEnter * setlocal formatoptions-=o
augroup END
"grep コマンドでackを使う
set grepprg=ack\ --nogroup\ --column\ -i\ $*
set grepformat=%f:%l:%c:%m
" ctagsファイルを遡って表示
set tags=_tags;
" grepの結果後自動的にQuickFixを開く
autocmd QuickFixCmdPost *grep* cw

"============================================================
" 文字コードの設定
"============================================================
"UTF-8を標準とする
set encoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set fileformats=unix,dos,mac
"改行コードを表示
set list
set listchars=tab:￫\ ,trail:~,eol:↲
" phpmanualで文字化けしない設定
if has("win32")
    let &termencoding = &encoding
endif

"============================================================
"全角スペースを表示
"============================================================
"コメント以外で全角スペースを指定しているので scriptencodingと、
"このファイルのエンコードが一致するよう注意！
"全角スペースが強調表示されない場合、ここでscriptencodingを指定すると良い。
"scriptencoding cp932

"デフォルトのZenkakuSpaceを定義
function! ZenkakuSpace()
  " highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guifg=darkgrey
  " highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
  highlight ZenkakuSpace cterm=reverse ctermfg=darkgrey gui=reverse guifg=DarkMagenta
endfunction

if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    " ZenkakuSpaceをカラーファイルで設定するなら次の行は削除
    autocmd ColorScheme       * call ZenkakuSpace()
    " 全角スペースのハイライト指定
    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    autocmd VimEnter,WinEnter * match ZenkakuSpace '\%u3000'
  augroup END
  call ZenkakuSpace()
endif

"============================================================
" HTML閉じタク補完
"============================================================
augroup MyXML
    autocmd!
    autocmd FileType xml inoremap <buffer> </ </<C-x><C-o>
    autocmd FileType html inoremap <buffer> </ </<C-x><C-o>
augroup END

"============================================================
" 括弧の補完
"============================================================
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>

"============================================================
"  Search option
"============================================================
"検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
"検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
"検索時に最後まで行ったら最初に戻る
set wrapscan
" 大文字小文字の検索を区別する
"検索結果文字列のハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

"============================================================
"  エクステンション設定
"============================================================
" indentLine
let g:indentLine_enabled = 1
"let g:indentLine_setColors = 0
let g:indentLine_color_gui = '#A4E57E'
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 2

"============================================================
" open-browser.vim
"============================================================
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

"============================================================
" unite.vimの設定
"============================================================
" ファイル一覧
noremap <C-U><C-F> :Unite -buffer-name=file file<CR>
" 最近使ったファイル一覧
noremap <C-U><C-R> :Unite file_mru<CR>

" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-i> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-i> unite#do_action('split')

" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q

"============================================================
" neocompleteの設定
"============================================================
"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

"============================================================
"  キーマップ設定
"============================================================
" コマンドラインモードで%%を入れると現在開いているファイルのディレクトリを指定する
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
" kのコマンドをgkに置き換える
nnoremap k gk
nnoremap gk k
" jのコマンドをgjに置き換える
nnoremap j gj
nnoremap gj j
" C-p を Upキーにマッピング
cnoremap <C-p> <Up>
" C-n を Downキーにマッピング
cnoremap <C-n> <Down>
" TagbarをF12で実行できるようにする
nmap <F12> :TagbarToggle<CR>
" NERDTree設定
nnoremap <silent><C-e> :NERDTreeToggle<CR>
" ctagsをF5で実行できるようにする
nnoremap <f5> :!ctags<CR>
" ctrl-sでファイル保存するようにする
noremap <C-S>       :update<CR>
vnoremap <C-S>      <C-C>:update<CR>
inoremap <C-S>      <C-O>:update<CR>
" ctrl-qでファイルを閉じる
" 記入モード
inoremap <C-q> <Esc>:q<CR>
" コマンドモード時
nnoremap <C-q> :q<CR>
"============================================================
"オリジナルキーマップ設定
"============================================================
nnoremap s <Nop>
" 新規タブ
nnoremap st :<C-u>tabnew<CR>
" 次のタブ
nnoremap sn gt
" 前のタブ
nnoremap sp gT
" ウインドウを閉じる
nnoremap sq :<C-u>q<CR>
" バッファを閉じる
nnoremap sQ :<C-u>bd<CR>
" タブ一覧  unite.vim
nnoremap sT :<C-u>Unite tab<CR>
" 現在のタブで開いたバッファ一覧 unite.vim
nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
" バッファ一覧 unite.vim
nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>
" 水平分割
nnoremap ss :<C-u>sp<CR>
" 垂直分割
nnoremap sv :<C-u>vs<CR>
"============================================================
"  拡張子別設定ファイルを呼び出す
"============================================================
" phpファイルのコメントアウト文字は // にする
autocmd BufNewFile,BufRead *.php\|*.inc setlocal commentstring=//\ %s
" phpファイルを開いたときは、bin/vimfiles/ftplugin/php.vimを読み込む
autocmd BufRead,BufNewFile *.php\|*.inc setfiletype php

" cssファイルを開いたときは、bin/vimfiles/ftplugin/css.vimを読み込む
autocmd BufRead,BufNewFile *.css setfiletype css

" jsファイルを開いたときは、bin/vimfiles/ftplugin/javascript.vimを読み込む
autocmd BufRead,BufNewFile *.js setfiletype javascript

" sqlファイルを開いたときは、bin/vimfiles/ftplugin/sql.vimを読み込む
autocmd BufRead,BufNewFile *.sql setfiletype sql

" pyファイルを開いたときは、bin/vimfiles/ftplugin/python.vimを読み込む
autocmd BufRead,BufNewFile *.py setfiletype python

" htmlファイルを開いたときは、bin/vimfiles/ftplugin/html.vimを読み込む
autocmd BufRead,BufNewFile *.html setfiletype html
