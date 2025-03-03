source ~/.config/fish/aliases.fish

set fish_greeting
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
  export ZELLIJ_CONFIG_DIR=$HOME/.config/zellij

  if [ "$TERM" = "xterm-ghostty" ]
    eval (zellij setup --generate-auto-start fish | string collect)
  end
end

if command -v zoxide >/dev/null
    zoxide init fish | source
end

set plugins ~/.config/fish/plugins/

for file in $plugins/*.fish
    source $file
end

if test -d ~/.asdf
    source ~/.asdf/asdf.fish
end
