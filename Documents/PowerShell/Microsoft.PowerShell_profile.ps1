Set-Alias vim nvim
Set-PSReadLineKeyHandler -Key Tab -Function Complete

oh-my-posh init pwsh --config '~\.config\ohmyposh\yuu528.omp.json' | Invoke-Expression
