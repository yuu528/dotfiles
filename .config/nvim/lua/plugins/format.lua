return {
    {
        'stevearc/conform.nvim',
        setup = true,
        event = 'BufWritePre',
        cmd = 'ConformInfo',
        keys = {
            {
                'gf',
                function()
                    require 'conform'.format({async = true, lsp_fallback = true})
                end,
                desc = 'Format buffer'
            }
        },
        opts = {
            formatters_by_ft = {
                lua = {'stylua'},
                c = {'astyle'},
                java = {'astyle'},
                bash = {'beautysh'},
                javascript = {'eslint_d'},
                typescript = {'eslint_d'},
                markdown = {'markdownlint'},
                latex = {'latexindent'},
                tex = {'latexindent'}
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true
            }
        },
        init = function()
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        end
    }
}
