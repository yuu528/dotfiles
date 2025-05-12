return {
    'mfussenegger/nvim-jdtls',
    'mfussenegger/nvim-lint',
    'rshkarin/mason-nvim-lint',
    {
        'williamboman/mason-lspconfig.nvim',
        tag = 'v1.32.0'
    },
    {
        'williamboman/mason.nvim',
        tag = 'v1.11.0'
    },
    {
        'neovim/nvim-lspconfig',
        lazy = false,
        config = function()
            local function setup_lsp()
                require 'mason'.setup()

                local mason_lspconfig = require 'mason-lspconfig'

                mason_lspconfig.setup()

                local lspconfig = require 'lspconfig'

                mason_lspconfig.setup_handlers {
                    function(server)
                        lspconfig[server].setup {}
                    end,
                    ['ts_ls'] = function()
                        local vue_ts_plugin =
                            require 'mason-registry'
                            .get_package 'vue-language-server'
                            :get_install_path() ..
                            '/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin'

                        lspconfig['ts_ls'].setup {
                            init_options = {
                                plugins = {
                                    {
                                        name = '@vue/typescript-plugin',
                                        location = vue_ts_plugin,
                                        languages = {
                                            'javascript',
                                            'typescript',
                                            'vue'
                                        }
                                    }
                                }
                            }
                        }
                    end
                }
            end

            local function setup_linter()
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
            format = function(diagnostic)
                return string.format(
                    '%s  %s (%s #%s)',
                    vim.diagnostic.config().signs.text[diagnostic.severity],
                    diagnostic.message,
                    diagnostic.source,
                    diagnostic.code
                )
            end,
            toggle_event = { 'InsertEnter', 'InsertLeave' },
            padding_right = 2
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
