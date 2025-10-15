return {
    {
        'mattn/emmet-vim',
        ft = { 'html', 'css' }
    },
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        opts = {
            map_cr = true
        }
    },
    {
        'machakann/vim-sandwich',
        event = { 'BufRead', 'BufNewFile' }
    },
    {
        'jsborjesson/vim-uppercase-sql',
        ft = 'sql'
    },
    {
        'yutkat/wb-only-current-line.nvim',
        event = { 'BufRead', 'BufNewFile' },
    },
}
