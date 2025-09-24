return {
    {
        'famiu/bufdelete.nvim',
        cmd = { 'Bdelete', 'Bwipeout' }
    },
    {
        'uga-rosa/ccc.nvim',
        cmd = {
            'CccPick',
            'CccConvert',
            'CccHighlighterEnable',
            'CccHighlighterDisable',
            'CccHighlighterToggle'
        },
        config = true
    },
    {
        'rhysd/clever-f.vim',
        keys = {
            { 'f' },
            { 'F' },
            { 't' },
            { 'T' },
            { ';', '<Plug>(clever-f-repeat-forward)', desc = 'Repeat forward' },
            { ',', '<Plug>(clever-f-repeat-back)',    desc = 'Repeat back' }
        }
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
        'NMAC427/guess-indent.nvim',
        event = { 'BufRead', 'BufNewFile' },
        config = true,
        opts = {
            auto_cmd = true,
        }
    },
    {
        'm4xshen/hardtime.nvim',
        lazy = false,
        dependencies = {
            'MunifTanjim/nui.nvim'
        },
        config = {
            disable_mouse = false,
            disabled_keys = {
                ['<Up>'] = false,
                ['<Down>'] = false
            }
        }
    },
    {
        'ysmb-wtsg/in-and-out.nvim',
        keys = {
            {
                '<C-CR>',
                function()
                    require('in-and-out').in_and_out()
                end,
                mode = 'i'
            }
        },
        config = true
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
        'nvim-mini/mini.nvim',
        version = '*'
    },
    {
        'nvim-mini/mini.pairs',
        version = '*',
        event = 'InsertEnter',
        config = true
    },
    {
        'jghauser/mkdir.nvim',
        event = { 'BufRead', 'BufNewFile' }
    },
    {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v3.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'MunifTanjim/nui.nvim',
            'nvim-tree/nvim-web-devicons'
        },
        lazy = false,
        config = function()
            vim.keymap.set('n', '<C-n>', '<CMD>Neotree toggle<CR>', {
                noremap = true, silent = true, desc = 'Toggle file explorer'
            })

            require 'neo-tree'.setup {
                close_if_last_window = true,
                window = {
                    mappings = {
                        ['l'] = 'open'
                    }
                },
                filesystem = {
                    filtere_items = {
                        visible = true,
                        hide_dotfiles = false,
                        hide_gitignored = false,
                        hide_hidden = false
                    }
                }
            }
        end
    },
    {
        'equalsraf/neovim-gui-shim',
        lazy = false
    },
    {
        'nacro90/numb.nvim',
        config = true
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
        'antosha417/nvim-lsp-file-operations',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-neo-tree/neo-tree.nvim'
        },
        config = true
    },
    {
        's1n7ax/nvim-window-picker',
        version = '2.*',
        opts = {
            filter_rules = {
                include_current_win = false,
                autoselect_one = true,
                bo = {
                    filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
                    buftype = { 'terminal', 'quickfix' }
                }
            },
        }
    },
    {
        'nvim-lua/plenary.nvim'
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
        cmd = 'Telescope',
        keys = {
            { '<LEADER>ff', '<CMD>Telescope find_files' .. ((vim.g.os ~= 'win') and 'hidden=true' or '') .. '<CR>', desc = 'Open file finder' },
            { '<LEADER>fg', '<CMD>Telescope live_grep<CR>',                                                         desc = 'Open live grep' },
            { '<LEADER>fb', '<CMD>Telescope buffers<CR>',                                                           desc = 'Open buffer finder' },
            { '<LEADER>fh', '<CMD>Telescope help_tags<CR>',                                                         desc = 'Open help finder' },
            { '<LEADER>fn', '<CMD>Telescope noice<CR>',                                                             desc = 'Open notification finder' }
        },
        config = function()
            require 'telescope'.load_extension 'noice'
            require 'telescope'.setup {
            }
        end
    },
    {
        'lervag/vimtex',
        lazy = false,
        ft = { 'tex', 'ltx' },
        init = function()
            vim.g.vimtex_view_general_viewer = 'SumatraPDF'
            vim.g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
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
