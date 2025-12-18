return {
    {
        'equalsraf/neovim-gui-shim',
        lazy = false
    },
    {
        'antosha417/nvim-lsp-file-operations',
        dependencies = {
            'nvim-lua/plenary.nvim',
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
                    filetype = { 'notify' },
                    buftype = { 'terminal', 'quickfix' }
                }
            },
        }
    },
}
