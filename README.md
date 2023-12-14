# dotfiles

my dotfiles

## Contents

|           Index           |
| ------------------------- |
| [Alacritty](#alacritty)   |
| [bash](#bash)             |
| [clang](#clang)           |
| [GlazeWM](#glazewm)       |
| [i3](#i3)                 |
| [latexmk](#latexmk)       |
| [Neovim](#neovim)         |
| [Oh My Posh](#oh-my-posh) |
| [PowerShell](#powershell) |
| [Tridactyl](#tridactyl)   |
| [vifm](#vifm)             |
| [Wezterm](#wezterm)       |

### Alacritty

- Path: `.config/alacritty`

### Bash

#### Installation

- Linux: `ln -s <Path to this repository>/.bashrc ~/.bashrc`

#### Files

`.bashrc`

### clang

#### Installation

- Linux: `sudo ln -s <Path to this repository>/.clang-format /.clang-format`

#### Files

`.clang-format`

### GlazeWM

#### Installation

- Windows: `mklink %userprofile%\.glaze-wm\config.yaml <Path to this repository>\.glaze-wm\config.yaml`

#### Path

`.glaze-wm`

#### Files

- `config.yaml`

### i3

- Path: `config/i3`
- Files
  - `config`

### latexmk

#### Installation

- Linux: `cp <Path to this repository>/.latexmkrc ~/.latexmkrc`
- Windows: `copy <Path to this repository>\.latexmkrc %userprofile%\.latexmkrc`

#### Files

`.latexmkrc`

### Neovim

#### Installation

- Linux: `ln -s <Path to this repository>/.config/nvim ~/.config/nvim`
- Windows: `mklink /j %localappdata%\nvim <Path to this repository>\.config\nvim`

#### Path

`.config/nvim`

#### Files

- `ftplugin/*`
- `lua/*`
- `init.lua`

### Oh My Posh

#### Installation

- Windows
    1. Install [PowerShell dotfiles](#powershell) first
    2. `mklink /j %userprofile%\.config\ohmyposh <Path to this repository>\.config\ohmyposh`

#### Path

`.config/ohmyposh`

#### Files

- `yuu528.omp.json`

### PowerShell

#### Installation

- Windows: `mklink %userprofile%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1 <Path to this repository>\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`

#### Path

`Documents\PowerShell`

#### Files

- `Microsoft.PowerShell_profile.ps1`

### Tridactyl

#### Installation

- Linux: `ln -s <Path to this repository>/.config/tridactyl ~/.config/tridactyl`
- Windows: `mklink /j %userprofile%\.config\tridactyl <Path to this repository>\.config\tridactyl`

#### Path

`.config/tridactyl`

#### Files

- `tridactylrc`

### vifm

#### Installation

- Linux: `ln -s <Path to this repository>/.vifm ~/.vifm`
- Windows: `mklink /j %userprofile%\.vifm <Path to this repository>\.vifm`

#### Path

`.vifm`

#### Files

- `*`

### Wezterm

#### Installation

- Linux: `ln -s <Path to this repository>/.config/wezterm ~/.config/wezterm`
- Windows: `mklink /j %userprofile%\.config\wezterm <Path to this repository>\.config\wezterm`

#### Path

`.config/wezterm`

#### Files

- `wezterm.lua`
