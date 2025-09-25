return {
    {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        config = function()
            require 'snippets.tex'
            require 'luasnip.loaders/from_vscode'.lazy_load()
        end
    },
    {
        'yutkat/confirm-quit.nvim',
        event = 'CmdlineEnter',
        config = true
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
        'nacro90/numb.nvim',
        event = { 'CmdlineEnter' },
        config = true,
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
                file_ignore_patterns = { 'node_modules', '.git/' }
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
}
