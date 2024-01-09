return {
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path'
        },
        event = { 'InsertEnter' },
        config = function()
            local lsp_zero = require 'lsp-zero'
            lsp_zero.extend_cmp()

            local cmp = require 'cmp'
            local cmp_action = lsp_zero.cmp_action()

            local lspkind = require 'lspkind'
            local luasnip = require 'luasnip'

            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end
                },
                sources = {
                    { name = 'buffer' },
                    { name = 'luasnip' },
                    { name = 'nvim_lsp' },
                    { name = 'path' }
                },
                mapping = cmp.mapping.preset.insert {
                    ['<TAB>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
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
                    },
                    ['<C-j>'] = cmp.mapping(function(fallback)
                        if luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<C-k>'] = cmp.mapping(function(fallback)
                        if luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' })
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
        'hrsh7th/cmp-buffer'
    },
    {
        'saadparwaiz1/cmp_luasnip',
        dependencies = {
            'L3MON4D3/LuaSnip'
        },
    },
    {
        'hrsh7th/cmp-nvim-lsp'
    },
    {
        'hrsh7th/cmp-nvim-lsp-document-symbol'
    },
    {
        'hrsh7th/cmp-nvim-lsp-signature-help'
    },
    {
        'hrsh7th/cmp-path'
    },
    {
        'rafamadriz/friendly-snippets'
    },
    {
        'onsails/lspkind.nvim'
    },
    {
        'L3MON4D3/LuaSnip',
        dependencies = {
            'rafamadriz/friendly-snippets'
        },
        config = function()
            require 'snippets.tex'
            require 'luasnip.loaders/from_vscode'.lazy_load()
        end
    }
}

