return {
    {
        'neovim/nvim-lspconfig',
        event = {'BufReadPre', 'BufNewFile'},
        dependencies = {
            'williamboman/mason-lspconfig.nvim',
            'folke/neodev.nvim'
        },
        config = function()
            require 'neodev'.setup()

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
                    'vuels',
                    'yamlls',
                },
                handlers = {
                    function(server)
                        require('lspconfig')[server].setup {
                            capabilities = require 'cmp_nvim_lsp'.default_capabilities()
                        }
                    end
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
        build = ':MasonUpdate',
        cmd = 'Mason',
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
        'j-hui/fidget.nvim',
        event = {'BufReadPre', 'BufNewFile'},
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
    }
}
