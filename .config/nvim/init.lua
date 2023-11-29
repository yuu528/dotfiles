-- options
-- encoding
vim.scriptencoding = 'utf-8'
vim.o.encoding = 'utf-8'
vim.o.fileencoding = 'utf-8'

-- file
vim.o.nobackup = true
vim.o.noswapfile = true
vim.o.autoread = true
vim.o.hidden = true

-- color
vim.o.termguicolors = true

-- ui
vim.o.showcmd = true
vim.o.laststatus = 2
vim.o.number = true
vim.o.signcolumn = 'yes'
vim.o.visualbell = true

-- command line
vim.o.wildmode = 'list:longest'

-- control
vim.o.mouse = ''

-- edit
vim.o.virtualedit = 'onemore'
vim.o.smartindent = true
vim.o.showmatch = true
vim.o.cursorline = true
vim.o.list = true
vim.opt.listchars = {tab = '─', space = '·'}
vim.o.tabstop = 4
vim.o.shiftwidth = 0
vim.o.softtabstop = -1

-- search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.wrapscan = true
vim.o.hlsearch = true


-- mapping
-- leader
vim.keymap.set('n', ' ', '<NOP>')
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- line moving
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')


-- autocmds
-- filetype indent settings
vim.api.nvim_create_augroup('indent', {clear = true})
vim.api.nvim_create_autocmd(
    { 'FileType' },
    {
        pattern = 'c',
        group = 'indent',
        command = 'setlocal ts=2 et'
    }
)
vim.api.nvim_create_autocmd(
    { 'FileType' },
    {
        pattern = 'lua',
        group = 'indent',
        command = 'setlocal ts=4 et'
    }
)

-- functions
-- for coc.nvim mapping
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end


-- load lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

plugins = require('plugins')
require 'lazy'.setup(plugins, {
    defaults = {
        lazy = true
    }
})
