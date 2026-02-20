# Fish syntax highlighting - Gruvbox Dark palette
# Matches Ghostty theme and Starship prompt colors
#
# Gruvbox Dark reference:
#   bg0=#282828  bg1=#3c3836  bg2=#504945  bg3=#665c54
#   fg=#ebdbb2   gray=#928374
#   red=#fb4934  green=#b8bb26  yellow=#fabd2f  blue=#83a598
#   purple=#d3869b  aqua=#8ec07c  orange=#fe8019

# Erase stale universal color variables (one-time migration)
# Global scope (set -g) takes precedence, but universals linger in fish_variables.
# This cleans them up so only the chezmoi-managed globals remain.
for var in (set -Un | string match 'fish_color_*') (set -Un | string match 'fish_pager_color_*')
    set -eU $var
end

# Command input colors
set -g fish_color_normal ebdbb2
set -g fish_color_command b8bb26 --bold
set -g fish_color_keyword fe8019
set -g fish_color_param ebdbb2 --bold
set -g fish_color_option 83a598
set -g fish_color_quote fabd2f
set -g fish_color_error fb4934 --bold
set -g fish_color_comment 928374 --italics
set -g fish_color_operator 8ec07c
set -g fish_color_redirection 8ec07c --bold
set -g fish_color_end fe8019
set -g fish_color_escape d3869b
set -g fish_color_autosuggestion 665c54
set -g fish_color_valid_path --underline
set -g fish_color_selection ebdbb2 --background=504945
set -g fish_color_search_match fabd2f --background=504945
set -g fish_color_history_current --bold
set -g fish_color_cwd fabd2f

# Pager colors (tab completion menu)
set -g fish_pager_color_prefix fabd2f --bold
set -g fish_pager_color_completion ebdbb2
set -g fish_pager_color_description 928374
set -g fish_pager_color_selected_background --background=504945
set -g fish_pager_color_selected_prefix fabd2f --bold
set -g fish_pager_color_selected_completion ebdbb2 --bold
set -g fish_pager_color_selected_description 928374
