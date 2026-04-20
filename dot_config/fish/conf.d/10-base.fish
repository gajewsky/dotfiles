set fish_greeting
set -gx EDITOR nvim

# Gruvbox Dark for bat and glow (env vars for tools that don't read config files)
set -gx BAT_THEME gruvbox-dark
set -gx GLAMOUR_STYLE ~/.config/glow/gruvbox-dark.json

set -gx ZELLIJ_CONFIG_DIR $HOME/.config/zellij
set -gx PNPM_HOME "$HOME/Library/pnpm"
