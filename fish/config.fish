source ~/.config/fish/aliases.fish

set fish_greeting
set -x DOTFILES ~/.dotfiles
set -x VIMRC $HOME/.vimrc
set -x EDITOR /usr/bin/nvim
set -x MYVIMRC ~/.dotfiles/vim/.vimrc

# Add homebrew to PATH for Apple Silicon Macs
if test -d /opt/homebrew/bin
    set -gx PATH /opt/homebrew/bin $PATH
end

set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH
set -gx PATH ~/.cargo/bin $PATH
set -gx PATH ~/git-fuzzy/bin $PATH

if test -f /opt/dev/dev.fish
    source /opt/dev/dev.fish
end

set -gx ZELLIJ_CONFIG_DIR $HOME/.config/zellij

# Fix for prompt breaking in zellij
if set -q ZELLIJ
    set -gx pure_enable_single_line_prompt true
end

if command -v zoxide >/dev/null
    zoxide init fish | source
end

set plugins ~/.config/fish/plugins/

for file in $plugins/*.fish
    source $file
end

# Auto-launch zellij when opening ghostty
if status is-interactive
    and not set -q ZELLIJ
    and command -v zellij >/dev/null
    eval (zellij setup --generate-auto-start fish | string collect)
end
