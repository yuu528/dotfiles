-- options
-- encoding
vim.scriptencoding = 'utf-8'
vim.o.encoding = 'utf-8'
vim.o.fileencoding = 'utf-8'

-- file
vim.o.autoread = true
vim.o.hidden = true

-- color
vim.o.termguicolors = true

-- ui
vim.o.showcmd = true
vim.o.laststatus = 2
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'
vim.o.visualbell = true

-- command line
vim.o.wildmode = 'list:longest'

-- edit
vim.o.virtualedit = 'onemore'
vim.o.smartindent = true
vim.o.showmatch = true
vim.o.cursorline = true
vim.o.list = true
vim.opt.listchars = { tab = '──', space = '·' }
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
vim.api.nvim_create_augroup('indent', { clear = true })
vim.api.nvim_create_autocmd(
    { 'FileType' },
    {
        pattern = 'lua',
        group = 'indent',
        command = 'setlocal ts=4 et'
    }
)

-- LSP config
vim.api.nvim_create_augroup('UserLspConfig', {})
vim.api.nvim_create_autocmd(
    'LspAttach',
    {
        group = 'UserLspConfig',
        callback = function(ev)
            local bufopts = { silent = true, buffer = ev.buf }
            vim.keymap.set('n', 'K', '<CMD>lua vim.lsp.buf.hover()<CR>', bufopts)
            vim.keymap.set('n', 'gr', '<CMD>lua vim.lsp.buf.references()<CR>', bufopts)
            vim.keymap.set('n', 'gd', '<CMD>lua vim.lsp.buf.definition()<CR>', bufopts)
            vim.keymap.set('n', 'gD', '<CMD>lua vim.lsp.buf.declaration()<CR>', bufopts)
            vim.keymap.set('n', 'gi', '<CMD>lua vim.lsp.buf.implementation()<CR>', bufopts)
            vim.keymap.set('n', 'gt', '<CMD>lua vim.lsp.buf.type_definition()<CR>', bufopts)
            vim.keymap.set('n', 'gn', '<CMD>lua vim.lsp.buf.rename()<CR>', bufopts)
            vim.keymap.set('n', 'ga', '<CMD>lua vim.lsp.buf.code_action()<CR>', bufopts)
            vim.keymap.set('n', 'ge', '<CMD>lua vim.diagnostic.open_float()<CR>', bufopts)
            vim.keymap.set('n', 'g]', '<CMD>lua vim.diagnostic.goto_next()<CR>', bufopts)
            vim.keymap.set('n', 'g[', '<CMD>lua vim.diagnostic.goto_prev()<CR>', bufopts)
        end
    }
)

-- Change line number mode
vim.api.nvim_create_augroup('LineNumberMode', { clear = true })
vim.api.nvim_create_autocmd(
    'InsertEnter',
    {
        group = 'LineNumberMode',
        command = 'set norelativenumber'
    }
)
vim.api.nvim_create_autocmd(
    'InsertLeave',
    {
        group = 'LineNumberMode',
        command = 'set relativenumber'
    }
)

-- format toggle commands for Conform.nvim
vim.b.disable_autoformat = false
vim.g.disable_autoformat = false

vim.api.nvim_create_user_command(
    "FormatDisable",
    function(args)
        if args.bang then
            vim.b.disable_autoformat = true
        else
            vim.g.disable_autoformat = true
        end
    end,
    {
        desc = "Disable autoformat-on-save",
        bang = true,
    }
)

vim.api.nvim_create_user_command("FormatEnable",
    function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
    end,
    {
        desc = "Re-enable autoformat-on-save",
    }
)

-- get os
local os = 'unknown'
local arch = 'unknown'

if vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
    os = 'win'
elseif vim.fn.executable('uname') then
    arch = vim.fn.system('uname -m')
end


-- paths
if os == 'win' then
    local pyenv_python = vim.fn.expand('~\\.pyenv\\pyenv-win\\shims\\python.bat')

    if vim.fn.executable(pyenv_python) then
        vim.g.python3_host_prog = pyenv_python
    end

    if vim.fn.executable('pwsh') then
        vim.o.shell = 'pwsh'
    end
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


-- load for vscode, normal env or rpi
if vim.g.vscode then
    vim.keymap.set('n', '<LOCALLEADER><SPACE>', '<CMD>noh<CR>',
        { noremap = true, silent = true, desc = 'Clear highlights' }
    )

    require 'lazy'.setup('plugins_vscode', {
        defaults = {
            lazy = true
        }
    })
elseif os == 'win' or string.find(arch, 'x86_64') then
    require 'lazy'.setup('plugins', {
        defaults = {
            lazy = true
        }
    })
else
    require 'lazy'.setup('plugins_small', {
        defaults = {
            lazy = true
        }
    })
end
