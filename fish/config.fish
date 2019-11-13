if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

alias ls="exa -a"
alias cat="bat"
alias vim="nvim"
alias reload!="source ~/.config/fish/config.fish"

export VIMRC=$HOME/.vimrc

