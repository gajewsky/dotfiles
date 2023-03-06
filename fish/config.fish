source ~/.config/fish/aliases.fish

set -U FZF_COMPLETE 0
set -U FZF_LEGACY_KEYBINDINGS 0
set -U FZF_DEFAULT_COMMAND 'rg --files --follow --no-ignore-vcs --hidden --glob "!{node_modules/*,.git/*,sorbet/*}"'

set -U FZF_DEFAULT_OPTS '--layout=reverse --height 40%'
set -U FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

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

source ~/.asdf/asdf.fish
