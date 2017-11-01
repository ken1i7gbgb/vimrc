" dictファイルを作成したいときは以下のコマンドを打つ
" php -r '$f=get_defined_functions();echo join("\n",$f["internal"]);'|sort > ~/.vim/dict/php.dict
" 辞書検索はCtrl-x Ctrl-kで動作する
set dict=~/bin/vim/vimfiles/dict/php.dict

" Indent設定
set tabstop=4       " Tab文字を画面上で何文字分に展開するか
set shiftwidth=4    " indentやautoindent時に挿入されるインデントの幅
set softtabstop=0   " Tabキー押し下げ時の挿入される空白の量，0の場合はtabstopと同じ
set autoindent smartindent "自動インデント，スマートインデント

" )}を入力したとき、対応する括弧を表示
set showmatch

" タブ文字を表示
"set list

" Ctrl-hで画面を縦分割してタグジャンプ
"nnoremap <C-h> :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>
" Ctrl-kで画面を横分割してタグジャンプ
"nnoremap <C-k> :split<CR> :exe("tjump ".expand('<cword>'))<CR>

" phpマニュアルの設定
" let g:ref_phpmanual_path = $HOME . '\bin\vim\vimfiles\phpmanual'

" 保存時にPHPの構文チェックを行う
let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs = 1
let g:syntastic_echo_current_error = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_enable_highlighting = 1
let g:syntastic_php_php_args = '-l'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" 補完機能
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_smart_case = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_manual_completion_start_length = 0
let g:neocomplcache_caching_percent_in_statusline = 1
let g:neocomplcache_enable_skip_completion = 1
let g:neocomplcache_skip_input_time = '0.5'

" makeしたときにphp -lを行う
set makeprg=php\ -l\ %
