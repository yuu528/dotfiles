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
        'nvim-mini/mini.files',
        version = '*',
        keys = {
            {
                '<C-n>',
                function()
                    MiniFiles.open()
                end,
                desc = 'Open file explorer'
            }
        },
        config = function()
            local mini_files = require 'mini.files'

            mini_files.setup()

            -- Use ':w' to synchronize
            vim.api.nvim_create_autocmd('User', {
                pattern = 'MiniFilesBufferCreate',
                callback = function(ev)
                    vim.schedule(function()
                        vim.api.nvim_set_option_value('buftype', 'acwrite', { buf = 0 })
                        vim.api.nvim_buf_set_name(0, tostring(vim.api.nvim_get_current_win()))
                        vim.api.nvim_create_autocmd('BufWriteCmd', {
                            buffer = ev.data.buf_id,
                            callback = function()
                                mini_files.synchronize()
                            end
                        })
                    end)
                end
            })
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
        'akinsho/toggleterm.nvim',
        version = '*',
        keys = {
            { '<LEADER>te' }
        },
        config = function()
            require 'toggleterm'.setup {
                size = function(term)
                    if term.direction == 'horizontal' then
                        return 24
                    elseif term.direction == 'vertical' then
                        return vim.o.columns * 0.4
                    end
                end,
                open_mapping = [[<LEADER>te]]
            }

            local powershell_options = {
                shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell",
                shellcmdflag =
                "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
                shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
                shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
                shellquote = "",
                shellxquote = "",
            }

            for option, value in pairs(powershell_options) do
                vim.opt[option] = value
            end
        end,
        opts = {
            open_mapping = [[<LEADER>te]],
            hide_numbers = false,
        }
    },
    {
        'lervag/vimtex',
        lazy = false,
        ft = { 'tex', 'ltx' },
        init = function()
            vim.g.vimtex_view_general_viewer = 'SumatraPDF'
            vim.g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
        end
    }
}
