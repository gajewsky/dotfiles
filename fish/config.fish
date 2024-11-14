source ~/.config/fish/aliases.fish

set -x DOTFILES ~/.dotfiles
set -x VIMRC $HOME/.vimrc
set -x EDITOR /usr/bin/nvim
set -x MYVIMRC ~/.dotfiles/vim/.vimrc
# xset r rate 250 100
set PATH ~/bin $PATH
set PATH ~/.local/bin $PATH
set PATH ~/.cargo/bin $PATH
set PATH ~/git-fuzzy/bin $PATH

if test -f /opt/dev/dev.fish
    source /opt/dev/dev.fish
end

if status is-interactive
    # Check for zellij
    if command -v zellij >/dev/null
        eval (zellij setup --generate-auto-start fish | string collect)
    end
end

# Check for zoxide
if command -v zoxide >/dev/null
    zoxide init fish | source
end

set plugins ~/.config/fish/plugins/

for file in $plugins/*.fish
    source $file
end

