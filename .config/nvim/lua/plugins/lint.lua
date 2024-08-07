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
                tex = { 'lacheck' },
                latex = { 'lacheck' }
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
        config = function()
            local ensure_installed = {
                'eslint_d',
                'markdownlint'
            }

            if vim.fn.has('unix') == 1 then
                table.insert(ensure_installed, 'clang-format')
                table.insert(ensure_installed, 'pylint')
            end

            require 'mason-nvim-lint'.setup {
                ensure_installed = ensure_installed,
                automatic_installation = false
            }
        end
    }
}
