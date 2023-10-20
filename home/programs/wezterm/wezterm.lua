local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "Material Palenight (base16)"

config.font = wezterm.font_with_fallback {
  'Iosevka Nerd Font'
}

config.hide_mouse_cursor_when_typing = false

return config
