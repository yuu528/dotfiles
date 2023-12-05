return {
    {
        'mfussenegger/nvim-lint',
        event = { 'BufRead', 'BufNewFile' },
        config = function()
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
                tex = { 'chktex' },
                latex = { 'chktex' }
            }
        end
    },
    {
        'rshkarin/mason-nvim-lint',
        dependencies = {
            'williamboman/mason.nvim',
            'mfussenegger/nvim-lint'
        },
        event = { 'BufReadPre', 'BufNewFile' },
        config = true,
        opts = {
            ensure_installed = {
                'eslint_d',
                'pylint',
                'markdownlint',
                'clang-format',
                'clangd'
            },
            automatic_installation = false
        }
    }
}

