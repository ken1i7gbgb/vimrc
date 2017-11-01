" cssファイルを開いたとき、専用のdictファイルを読み込む
set dict=~/.vim/dict/css.dict

" makeコマンドで現在のcssファイルのエラーチェックを行う
set makeprg=csslint\ %
