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
        build = ':TSUpdate',
        event = { 'BufRead', 'BufNewFile' },
        dependencies = {
            'windwp/nvim-ts-autotag'
        },
        config = function()
            require 'nvim-treesitter.install'.prefer_git = false
            require 'nvim-treesitter.configs'.setup {
                ensure_installed = {
                    'bash', 'c', 'cmake', 'css', 'csv', 'diff', 'dot',
                    'git_config', 'git_rebase', 'gitattributes', 'gitcommit',
                    'gitignore', 'html', 'ini', 'java', 'javascript', 'json',
                    'lua', 'make', 'markdown', 'php', 'python', 'regex', 'sql',
                    'toml', 'tsv', 'typescript', 'vim', 'vimdoc', 'vue', 'xml', 'yaml'
                },
                highlight = {
                    enable = true
                },
                indent = {
                    enable = true
                }
            }
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
