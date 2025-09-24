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
                    diagnostics = 'nvim_lsp',
                    separator_style = 'slant',
                    numbers = 'buffer_id',
                    diagnostics_indicator = function(count, level)
                        local icon = level:match("error") and " " or " "
                        return " " .. icon .. count
                    end
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
        'lewis6991/gitsigns.nvim',
        event = { 'BufRead', 'BufNewFile' },
        config = true
    },
    {
        'shellRaining/hlchunk.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        config = true,
        opts = {
            chunk = {
                enable = true,
                delay = 0
            },
            indent = {
                enable = true
            },
            line_num = {
                enable = true
            },
            blank = {
                enable = true
            }
        }
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'AndreM222/copilot-lualine',
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

            -- Recording indicator
            vim.api.nvim_create_autocmd({ 'RecordingEnter', 'RecordingLeave' }, {
                callback = function()
                    require 'lualine'.refresh({ place = { 'statusline' } })
                end
            })

            local function recording_indicator()
                local reg = vim.fn.reg_recording()
                if reg ~= '' then
                    return '󰑊 ' .. reg
                else
                    return ''
                end
            end

            require 'lualine'.setup({
                sections = {
                    lualine_c = {
                        {
                            'navic'
                        },
                    },
                    lualine_x = {
                        {
                            recording_indicator,
                            color = { fg = '#FF5555' }
                        },
                        {
                            'copilot',
                            show_colors = true,
                            show_loading = true
                        },
                        'encoding',
                        'fileformat',
                        'filetype'
                    }
                }
            })
        end
    },
    {
        'ntpeters/vim-better-whitespace',
        event = { 'BufRead', 'BufNewFile' }
    },
    {
        'folke/noice.nvim',
        dependencies = {
            'MunifTanjim/nui.nvim',
        },
        event = 'VeryLazy',
        opts = {
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true
                },
            },
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = false,
                lsp_doc_border = false
            },
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
        'nvim-tree/nvim-web-devicons'
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
}
