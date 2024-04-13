Set-Alias vim nvim
Set-PSReadLineKeyHandler -Key Tab -Function Complete

oh-my-posh init pwsh --config '~\.config\ohmyposh\yuu528.omp.json' | Invoke-Expression

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
	Import-Module "$ChocolateyProfile"
}

# Need scoop-search (scoop install scoop-search)
Invoke-Expression (&scoop-search --hook)

# Environments
$Env:KOMOREBI_CONFIG_HOME = Join-Path $Env:USERPROFILE '.config' 'komorebi'
