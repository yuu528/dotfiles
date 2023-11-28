-- options
-- encoding
vim.scriptencoding = 'utf-8'
vim.o.encoding = 'utf-8'
vim.o.fileencoding = 'utf-8'

-- file
vim.o.nobackup = true
vim.o.noswapfile = true
vim.o.autoread = true
vim.o.hidden = true

-- color
vim.o.termguicolors = true

-- ui
vim.o.showcmd = true
vim.o.laststatus = 2
vim.o.number = true
vim.o.signcolumn = 'yes'
vim.o.visualbell = true

-- command line
vim.o.wildmode = 'list:longest'

-- control
vim.o.mouse = ''

-- edit
vim.o.virtualedit = 'onemore'
vim.o.smartindent = true
vim.o.showmatch = true
vim.o.cursorline = true
vim.opt.listchars = {tab = '─', space = '·'}
vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.wrapscan = true
vim.o.hlsearch = true


-- mapping
-- leader
vim.keymap.set('n', ' ', '<NOP>')
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- line moving
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')


-- functions
-- for coc.nvim mapping
function _G.check_back_space()
	local col = vim.fn.col('.') - 1
	return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end


-- load lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require 'lazy'.setup({
	{
		'akinsho/bufferline.nvim',
		version = '*',
		dependencies = 'nvim-tree/nvim-web-devicons',
		event = 'VimEnter',
		config = function()
			require 'bufferline'.setup {
				options = {
					color_icons = true,
					diagnostics = 'coc',
					separator_style = 'slant',
					numbers = 'buffer_id'
				}
			}
			local opts = {silent = true}
			vim.keymap.set('n', '<C-j>', ':BufferLineCyclePrev<CR>', opts)
			vim.keymap.set('n', '<C-k>', ':BufferLineCycleNext<CR>', opts)
			vim.keymap.set('n', '<C-h>', ':BufferLineMovePrev<CR>', opts)
			vim.keymap.set('n', '<C-l>', ':BufferLineMoveNext<CR>', opts)
		end
	},
	{
		'neoclide/coc.nvim',
		branch = 'release',
		event = {'InsertEnter', 'CmdlineEnter'},
		config = function()
			vim.g.coc_global_extensions = {
				'coc-clangd',
				'coc-java',
				'coc-lua',
				'coc-pairs',
				'coc-snippets',
				'coc-vimlsp',
				'coc-vimtex',
			}

			local opts = {silent = true, expr = true}
			vim.keymap.set('i', '<TAB>',
				'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()',
				opts
			)
			vim.keymap.set('i', '<S-TAB>', [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
			vim.keymap.set('i', '<CR>',
				[[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]],
				opts
			)
		end
	},
	{
		'yutkat/confirm-quit.nvim',
		event = 'CmdlineEnter',
		config = true
	},
	{
		'mattn/emmet-vim',
		ft = {'html', 'css'}
	},
	{
		'lambdalisue/fern.vim',
		dependencies = {
			'lambdalisue/fern-renderer-nerdfont.vim'
		},
		keys = {
			{'<C-n>', ':Fern . -reveal=% -drawer -toggle -width=35<CR>', desc = 'Toggle Fern', silent = true}
		},
		config = function()
			vim.g['fern#renderer'] = 'nerdfont'
			vim.g['fern#renderer#nerdfont#indent_markers'] = 1
			vim.g['fern#default_hidden'] = 1
		end
	},
	{
		'lewis6991/gitsigns.nvim',
		event = {'BufRead', 'BufNewFile'},
		config = true
	},
	{
		'ellisonleao/gruvbox.nvim',
		priority = 1000,
		lazy = false,
		config = function()
			require 'gruvbox'.setup({
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
			vim.o.background = 'dark'
			vim.cmd('colorscheme gruvbox')
		end
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = {
			'nvim-tree/nvim-web-devicons'
		},
		event = 'VimEnter',
		config = true
	},
	{
		'lambdalisue/fern-renderer-nerdfont.vim',
		dependencies = {
			'lambdalisue/nerdfont.vim'
		}
	},
	{
		'equalsraf/neovim-gui-shim',
	},
	{
		'norcalli/nvim-colorizer.lua',
		event = 'VeryLazy',
		config = true,
		opts = {
			'*'
		}
	},
	{
		'andersevenrud/nvim_context_vt',
		event = 'BufReadPost',
		config = true,
		opts = {
			enabled = true,
			prefix = '',
			disable_virtual_lines = true
		}
	},
	{
		'kevinhwang91/nvim-hlslens',
		event = 'CmdlineEnter',
		config = function()
			local opts = {noremap = true, silent = true}
			vim.keymap.set('n', 'n',
				[[<CMD>execute('normal! ' . v:count1 . 'n')<CR><CMD>lua require('hlslens').start()<CR>]],
				opts
			)
			vim.keymap.set('n', 'N',
				[[<CMD>execute('normal! ' . v:count1 . 'N')<CR><CMD>lua require('hlslens').start()<CR>]],
				opts
			)
			vim.keymap.set('n', '*', [[*<CMD>lua require('hlslens').start()<CR>]], opts)
			vim.keymap.set('n', '#', [[#<CMD>lua require('hlslens').start()<CR>]], opts)
			vim.keymap.set('n', 'g*', [[g*<CMD>lua require('hlslens').start()<CR>]], opts)
			vim.keymap.set('n', 'g#', [[g#<CMD>lua require('hlslens').start()<CR>]], opts)
			vim.keymap.set('n', '<LEADER>l', '<CMD>noh<CR>', opts)
		end
	},
	{
		'petertriho/nvim-scrollbar',
		dependencies = {
			'lewis6991/gitsigns.nvim',
			'kevinhwang91/nvim-hlslens'
		},
		event = {
			'BufWinEnter',
			'CmdwinLeave',
			'TabEnter',
			'TermEnter',
			'TextChanged',
			'VimResized',
			'WinEnter',
			'WinScrolled',
		},
		config = function()
			require 'scrollbar'.setup()
			require 'scrollbar.handlers.gitsigns'.setup()
			require 'scrollbar.handlers.search'.setup()
		end
	},
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		event = {'BufRead', 'BufNewFile'},
		config = function()
			require 'nvim-treesitter.install'.prefer_git = false
			require 'nvim-treesitter.configs'.setup {
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
		end
	},
	{
		'nvim-tree/nvim-web-devicons'
	},
	{
		'nvim-lua/plenary.nvim'
	},
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.4',
		dependencies = {
			'nvim-lua/plenary.nvim'
		},
		keys = {
			{'<LEADER>ff', '<CMD>Telescope find_files<CR>'},
			{'<LEADER>fg', '<CMD>Telescope live_grep<CR>'},
			{'<LEADER>fb', '<CMD>Telescope buffers<CR>'},
			{'<LEADER>fh', '<CMD>Telescope help_tags<CR>'}
		}
	},
	{
		'lervag/vimtex',
		ft = {'tex', 'ltx'},
		config = function()
			vim.g.vimtex_view_general_viewer = 'SumatraPDF'
			vim.g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
		end
	},
	{
		'RRethy/vim-illuminate',
		event = {'BufRead', 'BufNewFile'},
		config = function()
			require 'illuminate'.configure {
				providers = {
					'lsp',
					'treesitter',
					'regex'
				}
			}
		end
	},
	{
		'machakann/vim-sandwich',
		event = {'BufRead', 'BufNewFile'}
	},
	{
		'jsborjesson/vim-uppercase-sql',
		ft = 'sql'
	},
	{
		'Shougo/vinarise.vim',
		cmd = 'Vinarise'
	},
	{
		't9md/vim-quickhl',
		keys = {
			{'<SPACE>m', '<Plug>(quickhl-manual-this)', remap = true},
			{'<SPACE>m', '<Plug>(quickhl-manual-this)', remap = true, mode = 'x'},
			{'<SPACE>M', '<Plug>(quickhl-manual-reset)', remap = true},
			{'<SPACE>M', '<Plug>(quickhl-manual-reset)', remap = true, mode = 'x'},
		}
	},
	{
		'yutkat/wb-only-current-line.nvim',
		event = {'BufRead', 'BufNewFile'},
	},
	{
		'folke/which-key.nvim',
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {}
	},
}, {
	defaults = {
		lazy = true
	}
})
