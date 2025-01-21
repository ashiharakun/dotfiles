local wezterm = require 'wezterm'
require 'format'
require 'status'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = 'Tokyo Night'
config.window_background_opacity = 0.88
config.font = wezterm.font("PleckJP")
config.initial_rows = 38
config.initial_cols = 90
config.font_size = 16
config.keys = require("keybinds").keys
config.key_tables = require("keybinds").key_tables

config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 2000 }

config.status_update_interval = 1000
return config

