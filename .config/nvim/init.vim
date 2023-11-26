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

" set local leader key to ,
let maplocalleader = ","

" truecolor
set termguicolors

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

" Coc.nvim
function! CheckBackspace() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

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
	\'coc-lua',
	\'coc-pairs',
	\'coc-snippets',
	\'coc-vimlsp',
	\'coc-vimtex',
\]

" vimtex
let g:vimtex_view_general_viewer = 'SumatraPDF'
let g:vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'

" quickhl
nmap <Space>m <Plug>(quickhl-manual-this)
xmap <Space>m <Plug>(quickhl-manual-this)
nmap <Space>M <Plug>(quickhl-manual-reset)
xmap <Space>M <Plug>(quickhl-manual-reset)

" lua plugin settings
lua <<EOF
-- gruvbox.nvim
-- signcolumn color
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
vim.cmd('set background=dark')
vim.cmd('colorscheme gruvbox')

-- lualine
require'lualine'.setup {
	options = {
		icons_enabled = true,
		theme = 'gruvbox',
		component_separators = { left = '', right = ''},
		section_separators = { left = '', right = ''},
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		}
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'branch', 'diff', 'diagnostics' },
		lualine_c = { 'filename' },
		lualine_x = { 'encoding', 'fileformat', 'filetype' },
		lualine_y = { 'progress' },
		lualine_z = { 'location' }
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { 'filename' },
		lualine_x = { 'location' },
		lualine_y = {},
		lualine_z = {}
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {}
}

-- nvim-treesitter
require'nvim-treesitter.install'.prefer_git = false
require'nvim-treesitter.configs'.setup {
	ensure_installed = {
		'bash', 'c', 'cmake', 'css', 'csv', 'diff', 'dot',
		'git_config', 'git_rebase', 'gitattributes', 'gitcommit',
		'gitignore', 'html', 'ini', 'java', 'javascript', 'json',
		'lua', 'make', 'markdown', 'python', 'regex', 'sql',
		'toml', 'tsv','typescript', 'vim', 'vimdoc', 'vue', 'xml', 'yaml'
	},
	highlight = {
		enable = true
	},
	indent = {
		enable = true
	}
}

-- gitsigns
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

-- nvim-colorizer
require'colorizer'.setup {
	'*';
}

-- bufferline.nvim
require'bufferline'.setup {
	options = {
		color_icons = true,
		diagnostics = 'coc',
		separator_style = 'slant',
		numbers = 'buffer_id'
	}
}


-- nvim_context_vt
require'nvim_context_vt'.setup {
	enabled = true,
	prefix = '',
	disable_virtual_lines = true
}

-- nvim-scrollbar
require'scrollbar'.setup()
require'scrollbar.handlers.gitsigns'.setup()
require'scrollbar.handlers.search'.setup()

-- nvim-hlslens
local kopts = {noremap = true, silent = true}

vim.api.nvim_set_keymap('n', 'n',
[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
kopts)
vim.api.nvim_set_keymap('n', 'N',
[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
kopts)
vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', '<Leader>l', '<Cmd>noh<CR>', kopts)

-- vim-illuminate
require'illuminate'.configure {
	providers = {
		'lsp',
		'treesitter',
		'regex'
	}
}
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

" switching buffer by <C-j>, <C-k>
nnoremap <silent> <C-j> :bprev<CR>
nnoremap <silent> <C-k> :bnext<CR>

" moving buffer by <C-h>, <C-l>
nnoremap <silent><C-h> :BufferLineMovePrev<CR>
nnoremap <silent><C-l> :BufferLineMoveNext<CR>

" :noh by <localleader><Space>
nnoremap <silent> <localleader><Space> :noh<CR>

syntax enable

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
