return {
    {
        'mattn/emmet-vim',
        ft = { 'html', 'css' }
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
        'folke/flash.nvim',
        event = 'VeryLazy',
        opts = {},
        keys = {
            { 's', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Flash' },
            { 'S', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end, desc = 'Flash Treesitter' },
            { 'r', mode = 'o', function() require('flash').remote() end, desc = 'Remote Flash' },
            { 'R', mode = { 'o', 'x' }, function() require('flash').treesitter_search() end, desc = 'Treesitter Search' },
            { '<C-s>', mode = { 'c' }, function() require('flash').toggle() end, desc = 'Toggle Flash Search' }
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
        'OXY2DEV/markview.nvim',
        lazy = false,
        keys = {
            { '<LOCALLEADER>m', '<CMD>Markview Toggle<CR>', desc = 'Toggle Markview' }
        },
        opts = {
            preview = {
                icon_provider = 'devicons'
            }
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
        'yutkat/wb-only-current-line.nvim',
        event = { 'BufRead', 'BufNewFile' },
    },
}
