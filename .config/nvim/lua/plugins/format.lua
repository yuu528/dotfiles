return {
    {
        'stevearc/conform.nvim',
        event = 'BufWritePre',
        cmd = {
            'ConformInfo',
        },
        keys = {
            {
                'gf',
                function()
                    require 'conform'.format({ async = true, lsp_fallback = true })
                end,
                desc = 'Format buffer'
            }
        },
        setup = function()
            require 'conform'.setup {
                formatters_by_ft = {
                    lua = { 'stylua' },
                    c = { 'astyle' },
                    java = { 'astyle' },
                    bash = { 'beautysh' },
                    javascript = { 'eslint_d' },
                    typescript = { 'eslint_d' },
                    markdown = { 'markdownlint' },
                    latex = { 'latexindent' },
                    tex = { 'latexindent' },
                    vue = { 'prettier' }
                },
                format_on_save = function(bufnr)
                    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                        return
                    end
                    return { timeout_ms = 500, lsp_fallback = true }
                end,
            }
        end,
        init = function()
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        end
    }
}
