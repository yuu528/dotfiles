return {
    {
        'numToStr/Comment.nvim',
        dependencies = {
            'JoosepAlviste/nvim-ts-context-commentstring'
        },
        config = function()
            require('Comment').setup({
                pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
            })
        end
    },
    {
        'andersevenrud/nvim_context_vt',
        event = 'BufReadPost',
        config = true,
        opts = {
            enabled = true,
            prefix = '',
            disable_virtual_lines = true
        }
    },
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        branch = 'main',
        version = false,
        build = ':TSUpdate',
        dependencies = {
            'windwp/nvim-ts-autotag'
        },
        config = function()
            local group = vim.api.nvim_create_augroup('TreesitterConfig', { clear = true })
            vim.api.nvim_create_autocmd('FileType', {
                group = group,
                pattern = { '*' },
                callback = function(ctx)
                    local hasStarted = pcall(vim.treesitter.start)

                    if hasStarted then
                        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                        vim.bo.syntax = 'on'
                        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
                end
            })
        end
    },
    {
        'windwp/nvim-ts-autotag',
        events = { 'BufReadPre', 'BufNewFile' },
        config = true
    },
    {
        'JoosepAlviste/nvim-ts-context-commentstring',
        config = true,
        opts = {
            enable_autocmd = false
        }
    },
}
