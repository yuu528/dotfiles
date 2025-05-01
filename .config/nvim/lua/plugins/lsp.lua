return {
    'mfussenegger/nvim-jdtls',
    'mfussenegger/nvim-lint',
    'rshkarin/mason-nvim-lint',
    'williamboman/mason-lspconfig.nvim',
    'williamboman/mason.nvim',
    {
        'neovim/nvim-lspconfig',
        lazy = false,
        config = function()
            function setup_lsp()
                require 'mason'.setup()

                require 'mason-lspconfig'.setup()

                require 'mason-lspconfig'.setup_handlers {
                    function (server)
                        require 'lspconfig'[server].setup {}
                    end
                }
            end

            function setup_linter()
                vim.api.nvim_create_augroup('Linting', { clear = true })
                vim.api.nvim_create_autocmd(
                    { 'BufEnter', 'BufWritePost', 'InsertLeave' },
                    {
                        group = 'Linting',
                        callback = function()
                            require 'lint'.try_lint()
                        end
                    }
                )

                require 'lint'.linters_by_ft = {
                    javascript = { 'eslint_d' },
                    typescript = { 'eslint_d' },
                    python = { 'pylint' },
                    html = { 'tidy' },
                    lua = { 'luacheck' },
                    markdown = { 'markdownlint' },
                    c = { 'clangtidy' },
                    tex = { 'lacheck' },
                    latex = { 'lacheck' }
                }

                require 'mason-nvim-lint'.setup {
                    automatic_installation = false
                }
            end

            setup_lsp()
            setup_linter()

            vim.diagnostic.config {
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = " ",
                        [vim.diagnostic.severity.WARN]  = " ",
                        [vim.diagnostic.severity.HINT]  = "󰌶 ",
                        [vim.diagnostic.severity.INFO]  = " "
                    }
                }
            }

            vim.diagnostic.config {
                virtual_text = false
            }
        end
    },
    {
        'SmiteshP/nvim-navic',
        event = { 'BufRead', 'BufNewFile' },
        opts = {
            lsp = {
                auto_attach = true
            }
        }
    },
    {
        'j-hui/fidget.nvim',
        tag = 'v1.0.0',
        config = true
    },
    {
        'dgagn/diagflow.nvim',
        event = 'LspAttach',
        opts = {
            padding_right = 2,
            show_sign = true
        }
    },
    {
        'folke/trouble.nvim',
        cmd = {
            'Trouble'
        },
        keys = {
            { '<LEADER>xx', '<CMD>Trouble diagnostics toggle<CR>', desc = 'Toggle trouble.nvim' }
        },
        config = true
    },
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        }
    }
}
