local wezterm = require 'wezterm'

return {
  -- Font with fallback for better symbol rendering
  font = wezterm.font_with_fallback({
    "MesloLGS Nerd Font Mono",
    "Symbols Nerd Font Mono",
  }),
  font_size = 14,

  -- Match tmux color scheme
  color_scheme = "Catppuccin Macchiato",

  -- Terminal type for proper rendering
  term = "xterm-256color",

  window_background_opacity = 0.95,
  hide_tab_bar_if_only_one_tab = true,
  window_padding = {
    left = 10,
    right = 10,
    top = 10,
    bottom = 10,
  },
}
