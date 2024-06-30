-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Banana Blueberry'
config.font = wezterm.font 'FiraCode Nerd Font Mono'

-- Option key as Alt
config.send_composed_key_when_left_alt_is_pressed = true

-- and finally, return the configuration to wezterm
return config
