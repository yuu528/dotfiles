local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- Renderer
local gpus = wezterm.gui.enumerate_gpus()
local preferred_types = { 'DiscreteGpu', 'IntegratedGpu', 'Other', 'Cpu' }
local preferred_backends = { 'Vulkan', 'Dx12', 'Metal', 'Gl' }

local preferred_gpu = 1
preferred_gpu = (function()
    for _, type in ipairs(preferred_types) do
        for _, backend in ipairs(preferred_backends) do
            for i, gpu in ipairs(gpus) do
                if gpu.backend == backend and gpu.device_type == type then
                    return i
                end
            end
        end
    end
end)()

config.webgpu_preferred_adapter = gpus[preferred_gpu]
config.front_end = 'WebGpu'

-- Font
config.font = wezterm.font('PlemolJP Console NF')
config.font_size = 12

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
config.adjust_window_size_when_changing_font_size = false

-- Default Shell
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    config.default_prog = { 'pwsh' }
elseif wezterm.target_triple == 'x86_64-unknown-linux-gnu' then
    config.default_prog = { 'bash' }
end

return config
