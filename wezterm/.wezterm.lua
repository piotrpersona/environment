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

-- Forbig replacing != for ≠
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

config.keys = {
	-- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
    {key="LeftArrow", mods="OPT", action=wezterm.action{SendString="\x1bb"}},
    -- Make Option-Right equivalent to Alt-f; forward-word
    {key="RightArrow", mods="OPT", action=wezterm.action{SendString="\x1bf"}},

	-- Delete words with Alt + Backspace
	{ key = "Backspace", mods = "OPT", action = wezterm.action{SendString="\x17"} }, -- \x17 is Ctrl+W (delete word)
}
-- and finally, return the configuration to wezterm
return config
