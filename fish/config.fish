source ~/.config/fish/aliases.fish
source ~/.asdf/asdf.fish

if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

set -U LANG en_GB.UTF-8
set -U LC_CTYPE en_GB.UTF-8
set -U LC_ALL en_GB.UTF-8

set -U FZF_COMPLETE 0
set -U FZF_LEGACY_KEYBINDINGS 0

set -x DOTFILES ~/.dotfiles
set -x VIMRC $HOME/.vimrc
set -x EDITOR /usr/bin/nvim
set -x UID (id -u $USER)
set -x GID (id -g $USER)
set -x MYVIMRC ~/.dotfiles/vim/.vimrc
set -x KUBECONFIG $HOME/.kube/kubeconfig
set -x ASDF_RUBY_BUILD_VERSION master

# xset r rate 250 100

set PATH ~/bin $PATH
set PATH (yarn global bin) ~/bin $PATH

set PATH ~/.local/bin $PATH
set PATH ~/.cargo/bin $PATH
set PATH ~/git-fuzzy/bin $PATH

zoxide init fish | source

