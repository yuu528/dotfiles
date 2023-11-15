augroup MyAutoCmd
	autocmd!
augroup END

" Space highlighting
augroup HighlightTrailingSpaces
	autocmd!
	autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
	autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END

" User commands
command -nargs=1 Stw call SetTabWidth(<f-args>)
function SetTabWidth(width)
	let s:numWidth = str2nr(a:width)
	exec 'set ts=' . s:numWidth
	exec 'set sw=' . s:numWidth
	set noet
endfunction

command -nargs=1 Sts call SetTabSpaceWidth(<f-args>)
function SetTabSpaceWidth(width)
	call SetTabWidth(a:width)
	set et
endfunction

" dein directory
let s:dein_dir=expand('~/.cache/dein')
let s:dein_repo_dir=s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" clone dein if dein is not installed
if &runtimepath !~# '/dein.vim'
	if !isdirectory(s:dein_repo_dir)
		execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
	endif
	execute 'set runtimepath^=' . s:dein_repo_dir
endif

" load plugins from toml
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
if dein#load_state(s:dein_dir)
	call dein#begin(s:dein_dir)
	call dein#load_toml(s:toml_file)
	call dein#end()
	call dein#save_state()
endif

" install plugins
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

" set leader key to <SPACE>
nnoremap <SPACE> <Nop>
let mapleader = ' '

" telescope.nvim
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" fern
nnoremap <C-n> :Fern . -reveal=% -drawer -toggle -width=35<CR>
let g:fern#renderer = 'nerdfont'
let g:fern#renderer#nerdfont#indent_markers = 1
let g:fern#default_hidden = 1

" vim airline
let g:airline_theme = 'base16_gruvbox_dark_medium'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:python3_host_prog = 'python'

" nvim-treesitter
lua <<EOF
require 'nvim-treesitter.install'.prefer_git = false
require'nvim-treesitter.configs'.setup {
	ensure_installed = {
		'bash', 'c', 'cmake', 'css', 'csv', 'diff', 'dot',
		'git_config', 'git_rebase', 'gitattributes', 'gitcommit',
		'gitignore', 'html', 'ini', 'java', 'javascript', 'json',
		'lua', 'make', 'markdown', 'python', 'regex', 'toml', 'tsv',
		'typescript', 'vim', 'vimdoc', 'vue', 'xml', 'yaml'
	},
	highlight = {
		enable = true
	},
	indent = {
		enable = true
	}
}
EOF

" Coc.nvim
" press tab or shift tab to select completions
inoremap <silent><expr> <TAB>
			\ coc#pum#visible() ? coc#pum#next(1) :
			\ CheckBackspace() ? "\<Tab>" :
			\ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" press enter to accept selected completion
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
			\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

let g:coc_global_extensions = [
	\'coc-clangd',
	\'coc-java',
	\'coc-vimlsp',
	\'coc-lua',
\]

" gitsigns
lua <<EOF
require'gitsigns'.setup {
	signs = {
		add          = { text = '│' },
		change       = { text = '│' },
		delete       = { text = '_' },
		topdelete    = { text = '‾' },
		changedelete = { text = '~' },
		untracked    = { text = '┆' },
	},
	signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
	numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
	linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
	word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
	watch_gitdir = {
		follow_files = true
	},
	attach_to_untracked = true,
	current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
		delay = 1000,
		ignore_whitespace = false,
		virt_text_priority = 100,
	},
	current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil, -- Use default
	max_file_length = 40000, -- Disable if file is longer than this (in lines)
	preview_config = {
		-- Options passed to nvim_open_win
		border = 'single',
		style = 'minimal',
		relative = 'cursor',
		row = 0,
		col = 1
	},
	yadm = {
		enable = false
	},
}
EOF

" gruvbox.nvim
lua <<EOF
# signcolumn color
require("gruvbox").setup({
	overrides = {
		SignColumn = { link = 'Normal' },
		GruvboxGreenSign = { bg = '' },
		GruvboxOrangeSign = { bg = '' },
		GruvboxPurpleSign = { bg = '' },
		GruvboxYellowSign = { bg = '' },
		GruvboxRedSign = { bg = '' },
		GruvboxBlueSign = { bg = '' },
		GruvboxAquaSign = { bg = '' },
	},
})
EOF

set fenc=utf-8
set nobackup
set noswapfile
set autoread			" auto reloading the file that changed
set hidden				" enable hidden buffer
set showcmd
set mouse=				" disable mouse
set signcolumn=yes		" always show signcolumn

set number				" show line number
set cursorline			" highlight current line
set virtualedit=onemore	" allow cursor to move last of line
set smartindent
set visualbell
set showmatch
set laststatus=2		" always show status line
set wildmode=list:longest	" auto completion for command line

" replace j k
nnoremap j gj
nnoremap k gk

syntax enable

" truecolor
set termguicolors

" ambiwidth settings
set encoding=utf-8
"if exists('&ambw')
"  set ambiwidth=double
"endif

set list listchars=tab:\\─,space:\·	" tab and space visualising

" tab width
set tabstop=4
set shiftwidth=4

" ignore case when the query text not contain capital letter
" or else, dont ignore case
set ignorecase
set smartcase

set incsearch
set wrapscan			" return last search position to first position
set hlsearch			" search text highlighting
