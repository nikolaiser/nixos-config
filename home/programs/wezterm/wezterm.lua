local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "Material Palenight (base16)"

config.font = wezterm.font_with_fallback {
  'FiraCode Nerd Font'
}


return config
