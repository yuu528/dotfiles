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
        'jghauser/mkdir.nvim',
        event = { 'BufRead', 'BufNewFile' }
    },
    {
        'equalsraf/neovim-gui-shim',
        lazy = false
    },
    {
        'windwp/nvim-autopairs',
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
