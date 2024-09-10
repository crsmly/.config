-- Pull in the wezterm API
local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'rose-pine'

config.font = wezterm.font("JetBrains Mono")


return config
