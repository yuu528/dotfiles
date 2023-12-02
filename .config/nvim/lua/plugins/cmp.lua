return {
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'onsails/lspkind.nvim',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path'
        },
        event = {'InsertEnter'},
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
        'hrsh7th/cmp-buffer'
    },
    {
        'saadparwaiz1/cmp_luasnip'
    },
    {
        'hrsh7th/cmp-nvim-lsp'
    },
    {
        'hrsh7th/cmp-path'
    },
    {
        'onsails/lspkind.nvim'
    },
    {
        'L3MON4D3/LuaSnip',
        dependencies = {
            'saadparwaiz1/cmp_luasnip'
        }
    }
}
