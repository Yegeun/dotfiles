local wezterm = require 'wezterm'

return {
  font = wezterm.font("MesloLGS Nerd Font Mono"),
  font_size = 14,
  color_scheme = "Catppuccin Macchiato",
  window_background_opacity = 0.95,
  hide_tab_bar_if_only_one_tab = true,
  window_padding = {
    left = 10,
    right = 10,
    top = 10,
    bottom = 10,
  },
  default_prog = { "/Users/yegeunji/dotfiles/tmux-sessionizer" },
}
