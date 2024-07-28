return {
    {
        'famiu/bufdelete.nvim',
        cmd = { 'Bdelete', 'Bwipeout' }
    },
    {
        'akinsho/bufferline.nvim',
        version = '*',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'ellisonleao/gruvbox.nvim'
        },
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

            vim.keymap.set('n', '<C-j>', ':BufferLineCyclePrev<CR>',
                { silent = true, desc = 'Switch to previous buffer' })
            vim.keymap.set('n', '<C-k>', ':BufferLineCycleNext<CR>', { silent = true, desc = 'Switch to next buffer' })
            vim.keymap.set('n', '<C-h>', ':BufferLineMovePrev<CR>', { silent = true, desc = 'Move buffer to next' })
            vim.keymap.set('n', '<C-l>', ':BufferLineMoveNext<CR>', { silent = true, desc = 'Move buffer to previous' })
        end
    },
    {
        'yutkat/confirm-quit.nvim',
        event = 'CmdlineEnter',
        config = true
    },
    {
        'zbirenbaum/copilot.lua',
        cmd = 'Copilot',
        event = {
            'InsertEnter'
        },
        config = true,
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false }
        }
    },
    {
        'mattn/emmet-vim',
        ft = { 'html', 'css' }
    },
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
        keys = {
            { '<C-n>', '<CMD>NvimTreeToggle<CR>', desc = 'Toggle file explorer', silent = true }
        },
        config = function()
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
            require 'nvim-tree'.setup {
                view = {
                    width = 35
                },
                renderer = {
                    group_empty = true,
                    icons = {
                        glyphs = {
                            folder = {
                                arrow_closed = '',
                                arrow_open = '',
                                default = '',
                                open = '',
                                empty = '',
                                empty_open = '',
                                symlink = '',
                                symlink_open = '',

                            },
                            git = {
                                unstaged = '',
                                staged = '',
                                unmerged = '',
                                renamed = '',
                                untracked = '',
                                deleted = '',
                                ignored = ''
                            }
                        }
                    }
                },
                filters = {
                    dotfiles = false
                }
            }
        end
    },
    {
        'lewis6991/gitsigns.nvim',
        event = { 'BufRead', 'BufNewFile' },
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
        'NMAC427/guess-indent.nvim',
        event = { 'BufRead', 'BufNewFile' },
        config = true,
        opts = {
            auto_cmd = true,
        }
    },
    {
        'RaafatTurki/hex.nvim',
        event = { 'BufRead' },
        cmd = { 'HexDump', 'HexAssemble', 'HexToggle' },
        config = true
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        dependencies = {
            'nvim-treesitter/nvim-treesitter'
        },
        main = 'ibl',
        event = { 'BufRead', 'BufNewFile' },
        config = function()
            --[[
            local highlight = {
                'GruvboxRed', 'GruvboxGreen', 'GruvboxYellow', 'GruvboxBlue', 'GruvboxPurple', 'GruvboxAqua', 'GruvboxOrange'
            }
            ]]

            require 'ibl'.setup {
                indent = {
                    char = '▏',
                    tab_char = '▏',
                    --highlight = highlight
                },
                scope = {
                    show_start = false,
                    show_end = false
                }
            }
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
        'iamcco/markdown-preview.nvim',
        ft = { 'markdown', 'md' },
        keys = {
            { '<LOCALLEADER>mm', '<Plug>MarkdownPreviewToggle', desc = 'Markdown preview' }
        },
        build = function()
            vim.fn['mkdp#util#install']()
        end,
        config = function()
            vim.g.mkdp_browser = 'falkon'
        end
    },
    {
        'NeogitOrg/neogit',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim'
        },
        keys = {
            { '<LEADER>t', '<CMD>Neogit<CR>' }
        },
        config = true
    },
    {
        'equalsraf/neovim-gui-shim',
        lazy = false
    },
    {
        'windwp/nvim-autopairs',
        dependencies = {
            'hrsh7th/nvim-cmp'
        },
        event = 'InsertEnter',
        config = function()
            require 'nvim-autopairs'.setup {
                disable_filetype = { 'TelescopePrompt' }
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
            require 'hlslens'.setup()

            vim.keymap.set('n', 'n',
                [[<CMD>execute('normal! ' . v:count1 . 'n')<CR><CMD>lua require('hlslens').start()<CR>]],
                { noremap = true, silent = true, desc = 'Search next' }
            )
            vim.keymap.set('n', 'N',
                [[<CMD>execute('normal! ' . v:count1 . 'N')<CR><CMD>lua require('hlslens').start()<CR>]],
                { noremap = true, silent = true, desc = 'Search previous' }
            )
            vim.keymap.set('n', '*', [[*<CMD>lua require('hlslens').start()<CR>]],
                { noremap = true, silent = true, desc = 'Search the word under the cursor' }
            )
            vim.keymap.set('n', '#', [[#<CMD>lua require('hlslens').start()<CR>]],
                { noremap = true, silent = true, desc = 'Reverse search the word under the cursor' }
            )
            vim.keymap.set('n', 'g*', [[g*<CMD>lua require('hlslens').start()<CR>]],
                { noremap = true, silent = true, desc = 'Search the word under the cursor and jump' }
            )
            vim.keymap.set('n', 'g#', [[g#<CMD>lua require('hlslens').start()<CR>]],
                { noremap = true, silent = true, desc = 'Reverse search the word under the cursor and jump' }
            )
            vim.keymap.set('n', '<LOCALLEADER><SPACE>', '<CMD>noh<CR>',
                { noremap = true, silent = true, desc = 'Clear highlights' }
            )
        end
    },
    {
        'SmiteshP/nvim-navic',
        dependencies = {
            'neovim/nvim-lspconfig'
        },
        event = { 'BufRead', 'BufNewFile' },
        config = true,
        opts = {
            lsp = {
                auto_attach = true
            }
        }
    },
    {
        'dstein64/nvim-scrollview',
        event = { 'VeryLazy' },
        config = function()
            vim.api.nvim_create_augroup('InsertScrollView', { clear = true })
            vim.api.nvim_create_autocmd(
                { 'InsertEnter' },
                {
                    group = 'InsertScrollView',
                    command = 'ScrollViewDisable'
                }
            )
            vim.api.nvim_create_autocmd(
                { 'InsertLeave' },
                {
                    group = 'InsertScrollView',
                    command = 'ScrollViewEnable'
                }
            )
            require 'scrollview'.setup {
                signs_on_startup = {
                    'all'
                }
            }
        end
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        event = { 'BufRead', 'BufNewFile' },
        dependencies = {
            'windwp/nvim-ts-autotag'
        },
        config = function()
            require 'nvim-treesitter.install'.prefer_git = false
            require 'nvim-treesitter.configs'.setup {
                ensure_installed = {
                    'bash', 'c', 'cmake', 'css', 'csv', 'diff', 'dot',
                    'git_config', 'git_rebase', 'gitattributes', 'gitcommit',
                    'gitignore', 'html', 'ini', 'java', 'javascript', 'json',
                    'lua', 'make', 'markdown', 'php', 'python', 'regex', 'sql',
                    'toml', 'tsv', 'typescript', 'vim', 'vimdoc', 'vue', 'xml', 'yaml'
                },
                highlight = {
                    enable = true
                },
                indent = {
                    enable = true
                },
                autotag = {
                    enable = true
                }
            }
        end
    },
    {
        'windwp/nvim-ts-autotag',
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
            { '<LEADER>ff', '<CMD>Telescope find_files hidden=true<CR>', desc = 'Open file finder' },
            { '<LEADER>fg', '<CMD>Telescope live_grep<CR>',              desc = 'Open live grep' },
            { '<LEADER>fb', '<CMD>Telescope buffers<CR>',                desc = 'Open buffer finder' },
            { '<LEADER>fh', '<CMD>Telescope help_tags<CR>',              desc = 'Open help finder' }
        }
    },
    {
        'lervag/vimtex',
        ft = { 'tex', 'ltx' },
        config = function()
            vim.g.vimtex_view_general_viewer = 'SumatraPDF'
            vim.g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
        end
    },
    {
        'RRethy/vim-illuminate',
        event = { 'BufRead', 'BufNewFile' },
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
        event = { 'BufRead', 'BufNewFile' }
    },
    {
        'jsborjesson/vim-uppercase-sql',
        ft = 'sql'
    },
    {
        't9md/vim-quickhl',
        keys = {
            { '<SPACE>m', '<Plug>(quickhl-manual-this)',  desc = 'Highlight words under the cursor', remap = true },
            { '<SPACE>m', '<Plug>(quickhl-manual-this)',  desc = 'Highlight words under the cursor', remap = true, mode = 'x' },
            { '<SPACE>M', '<Plug>(quickhl-manual-reset)', desc = 'Clear quickhl highlights',         remap = true },
            { '<SPACE>M', '<Plug>(quickhl-manual-reset)', desc = 'Clear quickhl highlights',         remap = true, mode = 'x' },
        }
    },
    {
        'kana/vim-altercmd',
        event = { 'BufRead', 'BufNewFile' },
        config = function()
            vim.cmd 'AlterCommand bd Bdelete'
        end
    },
    {
        'ntpeters/vim-better-whitespace',
        event = { 'BufRead', 'BufNewFile' }
    },
    {
        'yutkat/wb-only-current-line.nvim',
        event = { 'BufRead', 'BufNewFile' },
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
