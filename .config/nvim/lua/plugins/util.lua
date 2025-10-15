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
            disabled_filetypes = {
                'fern'
            },
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
            { '<LEADER>ff', '<CMD>Telescope find_files<CR>',      desc = 'Open file finder' },
            { '<LEADER>fg', '<CMD>Telescope live_grep<CR>',       desc = 'Open live grep' },
            { '<LEADER>fb', '<CMD>Telescope buffers<CR>',         desc = 'Open buffer finder' },
            { '<LEADER>fh', '<CMD>Telescope help_tags<CR>',       desc = 'Open help finder' },
            { '<LEADER>fn', '<CMD>Telescope noice<CR>',           desc = 'Open notification finder' },
            { '<LEADER>fd', '<CMD>Telescope lsp_definitions<CR>', desc = 'Open definitions finder' },
            { '<LEADER>fr', '<CMD>Telescope lsp_references<CR>',  desc = 'Open references finder' }
        },
        config = function()
            require 'telescope'.load_extension 'noice'
            require 'telescope'.setup {
                file_ignore_patterns = { 'node_modules', '.git/' },
                defaults = {
                    preview = {
                        treesitter = false
                    }
                },
                pickers = {
                    find_files = {
                        find_command = { 'rg', '--files', '--hidden', '-g', '!.git' },
                        hidden = true,
                        no_ignore = true
                    }
                }
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
        'lambdalisue/vim-fern',
        dependencies = {
            'lambdalisue/vim-fern-git-status',
            'lambdalisue/vim-fern-renderer-nerdfont'
        },
        keys = {
            { '<C-n>', '<CMD>Fern . -reveal=% -drawer -toggle<CR>', desc = 'Toggle file explorer', silent = true }
        },
        config = function()
            vim.g['fern#renderer'] = 'nerdfont'
            vim.g['fern#renderer#nerdfont#indent_markers'] = 1
            vim.g['fern#default_hidden'] = 1

            vim.fn['fern_git_status#init']()

            vim.api.nvim_create_augroup('fern-custom', { clear = true })
            vim.api.nvim_create_autocmd({ 'FileType' }, {
                pattern = 'fern',
                group = 'fern-custom',
                command = 'setlocal nonumber | setlocal norelativenumber | setlocal signcolumn=no'
            })
        end
    },
}
