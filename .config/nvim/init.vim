augroup MyAutoCmd
	autocmd!
augroup END

augroup HighlightTrailingSpaces
	autocmd!
	autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
	autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END

" deinディレクトリ設定
let s:dein_dir=expand('~/.cache/dein')
let s:dein_repo_dir=s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" deinがなければclone
if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . s:dein_repo_dir
endif

" プラグインインストール
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(s:toml_file)
  call dein#end()
  call dein#save_state()
endif

" プラグインの自動インストール
if has('vim_starting') && dein#check_install()
  call dein#install()
endif

" GitHubのtokenを書いたファイルをsecret.tsvとして置くことで自動高速更新
" secret.tsvがなければ遅い可能性があるので更新しない
let s:secretFilePath = fnamemodify(expand('<sfile>'), ':h').'/secret.tsv'

if getftype(s:secretFilePath) != ''
	let s:secretFile = readfile(s:secretFilePath)

	if len(s:secretFile) > 0
		let g:dein#install_github_api_token = s:secretFile[0]

		" 1日1回更新チェックする
		let s:lastUpdateFilePath = fnamemodify(expand('<sfile>'), ':h').'/.last_update'
		let s:today = strftime('%Y/%m/%d')
		if getftype(s:lastUpdateFilePath) == ''
			echo "Updating..."
			call dein#check_update(v:true)
			call writefile([s:today], s:lastUpdateFilePath)
		else
			let s:lastUpdateFile = readfile(s:lastUpdateFilePath)
			if len(s:lastUpdateFile) > 0 && s:lastUpdateFile[0] != s:today
				echo "Updating..."
				call dein#check_update(v:true)
				call writefile([s:today], s:lastUpdateFilePath)
			endif
		endif
	endif
endif

" python
let g:python3_host_prog = 'python'
"文字コードをUTF-8に設定
set fenc=utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd

" 見た目系
" 行番号を表示
set number
" 現在の行を強調表示
set cursorline
" 現在の行を強調表示（縦）
"set cursorcolumn
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" インデントはスマートインデント
set smartindent
" ビープ音を可視化
set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk
" シンタックスハイライトの有効化
syntax enable
" vim-airline
let g:airline_theme = 'base16'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
" 曖昧幅文字の表示
set encoding=utf-8
if exists('&ambw')
  set ambiwidth=double
endif

" Tab系
" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:\▸\-
" Tab文字を半角スペースにする
" set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=4
" 行頭でのTab文字の表示幅
set shiftwidth=4

" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
