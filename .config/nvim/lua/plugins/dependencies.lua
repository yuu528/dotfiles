return {
    {
        'nvim-mini/mini.nvim',
        version = '*'
    },
    {
        'equalsraf/neovim-gui-shim',
        lazy = false
    },
    {
        'antosha417/nvim-lsp-file-operations',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-neo-tree/neo-tree.nvim'
        },
        config = true
    },
    {
        's1n7ax/nvim-window-picker',
        version = '2.*',
        opts = {
            filter_rules = {
                include_current_win = false,
                autoselect_one = true,
                bo = {
                    filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
                    buftype = { 'terminal', 'quickfix' }
                }
            },
        }
    },
    {
        'lambdalisue/vim-fern-renderer-nerdfont',
        dependencies = {
            'lambdalisue/vim-nerdfont'
        }
    },
}
