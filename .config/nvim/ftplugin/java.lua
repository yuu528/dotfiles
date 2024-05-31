local config = {
    root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
}

if vim.fn.has('win32') == 1 then
    config.cmd = {
        vim.fn.expand(vim.fn.stdpath('data') .. '/mason/bin/jdtls.cmd')
    }
else
    config.cmd = {
        vim.fn.expand(vim.fn.stdpath('data') .. '/mason/bin/jdtls')
    }
end

require 'jdtls'.start_or_attach(config)
