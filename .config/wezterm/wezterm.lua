local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Renderer
config.front_end = 'WebGpu'

-- Font
config.font = wezterm.font('PlemolJP Console NF', { weight = 'Medium' })
config.font_size = 10

-- Color
config.color_scheme = 'GruvboxDark'
config.bold_brightens_ansi_colors = "No"

-- Window
config.window_decorations = "RESIZE"
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0
}

-- Default Shell
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
	config.default_prog = { 'pwsh' }
elseif wezterm.target_triple == 'x86_64-unknown-linux-gnu' then
	config.default_prog = { 'bash' }
end

return config
