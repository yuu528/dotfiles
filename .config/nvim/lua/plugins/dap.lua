return {
    'nvim-neotest/nvim-nio',
    'jay-babu/mason-nvim-dap.nvim',
    {
        'mfussenegger/nvim-dap',
        keys = {
            { '<LEADER>db', '<CMD>DapToggleBreakpoint<CR>',           desc = 'Toggle breakpoint' },
            { '<LEADER>dc', '<CMD>DapContinue<CR>',                   desc = 'Continue' },
            { '<LEADER>di', '<CMD>DapStepInto<CR>',                   desc = 'Step into' },
            { '<LEADER>do', '<CMD>DapStepOver<CR>',                   desc = 'Step over' },
            { '<LEADER>dO', '<CMD>DapStepOut<CR>',                    desc = 'Step out' },
            { '<LEADER>dr', '<CMD>lua require "dap".repl.open()<CR>', desc = 'Open REPL' },
            { '<LEADER>dt', '<CMD>lua require "dap".terminate()<CR>', desc = 'Terminate session' }
        }
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = {
            'mfussenegger/nvim-dap',
            'nvim-neotest/nvim-nio',
        },
        keys = {
            { '<LEADER>du', '<CMD>lua require "dapui".toggle()<CR>', desc = 'Toggle DAP UI' },
        },
        config = true
    }
}
