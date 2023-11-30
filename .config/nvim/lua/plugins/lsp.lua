return {
    {
        'neovim/nvim-lspconfig',
        lazy = false,
    },
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = true
    },
    {
        'hrsh7th/cmp-buffer',
        lazy = false
    },
    {
        'L3MON4D3/LuaSnip',
        lazy = false
    },
    {
        'saadparwaiz1/cmp_luasnip',
        dependencies = {
            'L3MON4D3/LuaSnip'
        },
        lazy = false
    },
    {
        'hrsh7th/cmp-nvim-lsp',
        dependencies = {
            'neovim/nvim-lspconfig',
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim'
        },
        lazy = false
    },
    {
        'hrsh7th/cmp-path',
        lazy = false
    },
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = {
            'neovim/nvim-lspconfig',
            'williamboman/mason.nvim',
            'hrsh7th/cmp-nvim-lsp'
        },
        lazy = false,
        config = function()
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
                }

            }
            require 'mason-lspconfig'.setup_handlers {
                function(server)
                    require('lspconfig')[server].setup {
                        capabilities = require 'cmp_nvim_lsp'.default_capabilities(),
                        on_attach = function(_, bufnr)
                            local bufopts = {silent = true, buffer = bufnr}
                            vim.keymap.set('n', 'K',  vim.lsp.buf.hover(), bufopts)
                            vim.keymap.set('n', 'gf', vim.lsp.buf.formatting(), bufopts)
                            vim.keymap.set('n', 'gr', vim.lsp.buf.references(), bufopts)
                            vim.keymap.set('n', 'gd', vim.lsp.buf.definition(), bufopts)
                            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration(), bufopts)
                            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation(), bufopts)
                            vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition(), bufopts)
                            vim.keymap.set('n', 'gn', vim.lsp.buf.rename(), bufopts)
                            vim.keymap.set('n', 'ga', vim.lsp.buf.code_action(), bufopts)
                            vim.keymap.set('n', 'ge', vim.diagnostic.open_float(), bufopts)
                            vim.keymap.set('n', 'g]', vim.diagnostic.goto_next(), bufopts)
                            vim.keymap.set('n', 'g[', vim.diagnostic.goto_prev(), bufopts)
                        end,
                        diagnostics = {
                            virtual_text = {
                                prefix = 'icons'
                            }
                        }
                    }
                end
            }
        end
    },
    {
        'onsails/lspkind.nvim',
        lazy = false,
    },
    {
        'j-hui/fidget.nvim',
        event = {'BufReadPre', 'BufNewFile'},
        lazy = false,
        config = true
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'onsails/lspkind.nvim'
        },
        lazy = false,
        config = function()
            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end
            local lspkind = require 'lspkind'
            local luasnip = require 'luasnip'
            local cmp = require 'cmp'

            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end
                },
                sources = {
                    {name = 'buffer'},
                    {name = 'luasnip'},
                    {name = 'nvim_lsp'},
                    {name = 'path'}
                },
                mapping = cmp.mapping.preset.insert {
                    ['<TAB>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, {'i', 's'}),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ['<CR>'] = cmp.mapping {
                        i = function(fallback)
                            if cmp.visible() and cmp.get_active_entry() then
                                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                            else
                                fallback()
                            end
                        end,
                        s = cmp.mapping.confirm({ select = true }),
                        c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
                    }
                },
                formatting = {
                    format = lspkind.cmp_format {
                        mode = 'symbol',
                        maxwidth = 50,
                        ellipsis_char = '...',
                        before = function(entry, vim_item)
                            return vim_item
                        end
                    }
                }
            }
        end
    },
    {
        'folke/trouble.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        lazy = false,
        opts = {
            use_diagnostic_signs = true
        }
    },
}
