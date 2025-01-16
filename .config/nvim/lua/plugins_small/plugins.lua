return {
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
        'machakann/vim-sandwich',
        event = { 'BufRead', 'BufNewFile' }
    },
    {
        'ntpeters/vim-better-whitespace',
        event = { 'BufRead', 'BufNewFile' }
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
    {
        'lambdalisue/vim-fern-renderer-nerdfont',
        dependencies = {
            'lambdalisue/vim-nerdfont'
        }
    },
    {
        'yutkat/wb-only-current-line.nvim',
        event = { 'BufRead', 'BufNewFile' },
    }
}
