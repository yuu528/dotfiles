return {
    {
        'saghen/blink.cmp',
        dependencies = {
            'rafamadriz/friendly-snippets',
            'L3MON4D3/LuaSnip',
            'fang2hou/blink-copilot',
            'folke/lazydev.nvim',
        },
        event = { 'InsertEnter' },
        version = '1.*',
        opts = {
            keymap = {
                preset = 'enter',
                ['<Tab>'] = { 'select_next', 'fallback' },
                ['<S-Tab>'] = { 'select_prev', 'fallback' },
                ['<C-j>'] = { 'snippet_forward', 'fallback' },
                ['<C-k>'] = { 'snippet_backward', 'fallback' }
            },
            appearance = {
                nerd_font_variant = 'normal'
            },
            completion = {
                documentation = {
                    auto_show = true
                },
                list = {
                    selection = {
                        preselect = false,
                        auto_insert = false
                    }
                },
                ghost_text = {
                    enabled = true
                }
            },
            snippets = {
                preset = 'luasnip'
            },
            sources = {
                default = {
                    'lsp',
                    'lazydev',
                    'snippets',
                    'copilot',
                    'buffer',
                    'path'
                },
                providers = {
                    lazydev = {
                        name = 'LazyDev',
                        module = 'lazydev.integrations.blink'
                    },
                    copilot = {
                        name = 'Copilot',
                        module = 'blink-copilot',
                        async = true
                    }
                }
            },
        },
        opts_extend = {
            'sources.default'
        }
    }
}
