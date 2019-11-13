. ~/.config/fish/aliases.fish

set -U FZF_LEGACY_KEYBINDINGS 0

if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

export VIMRC=$HOME/.vimrc

