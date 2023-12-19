return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        config = false,
        init = function()
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end
    },
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'folke/neodev.nvim'
        },
        config = function()
            require 'neodev'.setup()

            local lsp_zero = require 'lsp-zero'
            lsp_zero.extend_lspconfig()

            lsp_zero.on_attach(function(client, bufnr)
                lsp_zero.default_keymaps({ buffer = bufnr })
            end)

            require 'mason-lspconfig'.setup {
                ensure_installed = {
                    'arduino_language_server',
                    'bashls',
                    'clangd',
                    'cssls',
                    'dotls',
                    'html',
                    'jdtls',
                    'jsonls',
                    'lemminx',
                    'lua_ls',
                    'marksman',
                    'pylsp',
                    'quick_lint_js',
                    'sqlls',
                    'taplo',
                    'texlab',
                    'tsserver',
                    'vimls',
                    'yamlls',
                },
                handlers = {
                    lsp_zero.default_setup,
                    jdtls = lsp_zero.noop
                }
            }

            local signs = { Error = " ", Warn = " ", Hint = "󰌶 ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

            vim.diagnostic.config {
                virtual_text = false
            }
        end
    },
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = true
    },
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = {
            'williamboman/mason.nvim',
        }
    },
    {
        'folke/neodev.nvim'
    },
    {
        'mfussenegger/nvim-jdtls',
        dependencies = {
            'neovim/nvim-lspconfig'
        },
        event = { 'BufReadPre', 'BufNewFile' },
    },
    {
        'j-hui/fidget.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        config = true
    },
    {
        'dgagn/diagflow.nvim',
        event = 'LspAttach',
        config = true,
        opts = {
            padding_right = 2,
            show_sign = true
        }
    },
    {
        'folke/trouble.nvim',
        keys = {
            { '<LEADER>xx', '<CMD>TroubleToggle<CR>', desc = 'Toggle trouble.nvim' }
        },
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        }
    }
}

