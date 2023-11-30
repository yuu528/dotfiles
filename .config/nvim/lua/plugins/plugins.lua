return {
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

            vim.keymap.set('n', '<C-j>', ':BufferLineCyclePrev<CR>', {silent = true, desc = 'Switch to previous buffer'})
            vim.keymap.set('n', '<C-k>', ':BufferLineCycleNext<CR>', {silent = true, desc = 'Switch to next buffer'})
            vim.keymap.set('n', '<C-h>', ':BufferLineMovePrev<CR>', {silent = true, desc = 'Move buffer to next'})
            vim.keymap.set('n', '<C-l>', ':BufferLineMoveNext<CR>', {silent = true, desc = 'Move buffer to previous'})
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
            'nvim-tree/nvim-web-devicons',
            'SmiteshP/nvim-navic'
        },
        event = 'VimEnter',
        config = function()
            local utils = require("lualine.utils.utils")
            local highlight = require("lualine.highlight")

            local diagnostics_message = require("lualine.component"):extend()

            diagnostics_message.default = {
                colors = {
                    error = utils.extract_color_from_hllist(
                        { "fg", "sp" },
                        { "DiagnosticError", "LspDiagnosticsDefaultError", "DiffDelete" },
                        "#e32636"
                    ),
                    warning = utils.extract_color_from_hllist(
                        { "fg", "sp" },
                        { "DiagnosticWarn", "LspDiagnosticsDefaultWarning", "DiffText" },
                        "#ffa500"
                    ),
                    info = utils.extract_color_from_hllist(
                        { "fg", "sp" },
                        { "DiagnosticInfo", "LspDiagnosticsDefaultInformation", "DiffChange" },
                        "#ffffff"
                    ),
                    hint = utils.extract_color_from_hllist(
                        { "fg", "sp" },
                        { "DiagnosticHint", "LspDiagnosticsDefaultHint", "DiffAdd" },
                        "#273faf"
                    ),
                },
            }

            require("lualine").setup({
                sections = {
                    lualine_c = {
                        {
                            'navic'
                        },
                    },
                }
            })
        end
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
        'windwp/nvim-autopairs',
        dependencies = {
            'hrsh7th/nvim-cmp'
        },
        event = 'InsertEnter',
        config = function()
            require 'nvim-autopairs'.setup {
                disable_filetype = {'TelescopePrompt'}
            }
            local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
            local cmp = require 'cmp'
            cmp.event:on(
                'confirm_done',
                cmp_autopairs.on_confirm_done()
            )
        end
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
            vim.keymap.set('n', 'n',
                [[<CMD>execute('normal! ' . v:count1 . 'n')<CR><CMD>lua require('hlslens').start()<CR>]],
                {noremap = true, silent = true, desc = 'Search next'}
            )
            vim.keymap.set('n', 'N',
                [[<CMD>execute('normal! ' . v:count1 . 'N')<CR><CMD>lua require('hlslens').start()<CR>]],
                {noremap = true, silent = true, desc = 'Search previous'}
            )
            vim.keymap.set('n', '*', [[*<CMD>lua require('hlslens').start()<CR>]],
                {noremap = true, silent = true, desc = 'Search the word under the cursor'}
            )
            vim.keymap.set('n', '#', [[#<CMD>lua require('hlslens').start()<CR>]],
                {noremap = true, silent = true, desc = 'Reverse search the word under the cursor'}
            )
            vim.keymap.set('n', 'g*', [[g*<CMD>lua require('hlslens').start()<CR>]],
                {noremap = true, silent = true, desc = 'Search the word under the cursor and jump'}
            )
            vim.keymap.set('n', 'g#', [[g#<CMD>lua require('hlslens').start()<CR>]],
                {noremap = true, silent = true, desc = 'Reverse search the word under the cursor and jump'}
            )
            vim.keymap.set('n', '<LOCALLEADER><SPACE>', '<CMD>noh<CR>',
                {noremap = true, silent = true, desc = 'Clear highlights'}
            )
        end
    },
    {
        'SmiteshP/nvim-navic',
        dependencies = {
            'neovim/nvim-lspconfig'
        },
        event = {'BufRead', 'BufNewFile'},
        config = true,
        opts = {
            lsp = {
                auto_attach = true
            }
        }
    },
    {
        'dstein64/nvim-scrollview',
        event = {'VeryLazy'},
        config = true,
        opts = {
            signs_on_startup = {
                'all'
            }
        }
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
            {'<LEADER>ff', '<CMD>Telescope find_files hidden=true<CR>', desc = 'Open file finder'},
            {'<LEADER>fg', '<CMD>Telescope live_grep<CR>', desc = 'Open live grep'},
            {'<LEADER>fb', '<CMD>Telescope buffers<CR>', desc = 'Open buffer finder'},
            {'<LEADER>fh', '<CMD>Telescope help_tags<CR>', desc = 'Open help finder'}
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
            {'<SPACE>m', '<Plug>(quickhl-manual-this)', desc = 'Highlight words under the cursor', remap = true},
            {'<SPACE>m', '<Plug>(quickhl-manual-this)', desc = 'Highlight words under the cursor', remap = true, mode = 'x'},
            {'<SPACE>M', '<Plug>(quickhl-manual-reset)', desc = 'Clear quickhl highlights', remap = true},
            {'<SPACE>M', '<Plug>(quickhl-manual-reset)', desc = 'Clear quickhl highlights', remap = true, mode = 'x'},
        }
    },
    {
        'ntpeters/vim-better-whitespace',
        event = {'BufRead', 'BufNewFile'}
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
}
