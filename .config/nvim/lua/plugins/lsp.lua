return {
    'mfussenegger/nvim-jdtls',
    'mfussenegger/nvim-lint',
    'rshkarin/mason-nvim-lint',
    'mason-org/mason.nvim',
    {
        'mason-org/mason-lspconfig.nvim',
        lazy = false,
        dependencies = {
            'mason-org/mason.nvim',
            'neovim/nvim-lspconfig',
            'saghen/blink.cmp'
        },
        config = function()
            local lspconfig = require 'lspconfig'

            -- ts_ls config
            local vue_ts_plugin = vim.fn.expand(
                '$MASON/packages/vue-language-server/node_modules/@vue/typescript-plugin'
            )

            vim.lsp.config('ts_ls', {
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
            })

            -- denols config
            vim.lsp.config('denols', {
                root_dir = lspconfig.util.root_pattern('deno.json')
            })

            require 'mason'.setup()
            require 'mason-lspconfig'.setup {
                ensure_installed = {
                    'ts_ls'
                }
            }

            vim.lsp.set_log_level("OFF")

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

            require 'mason-nvim-dap'.setup {
                automatic_installation = false
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
                'nvim-dap-ui'
            },
        }
    }
}
