source ~/.config/fish/aliases.fish

# macOS-specific paths
switch (uname)
  case Darwin
    if test -d /opt/homebrew/bin
      fish_add_path /opt/homebrew/bin
      fish_add_path /opt/homebrew/sbin
    end

    if test -x /opt/homebrew/bin/pyenv
      set -gx PYENV_ROOT $HOME/.pyenv
      fish_add_path $PYENV_ROOT/bin
      pyenv init - | source
    end
end

set fish_greeting
set -x DOTFILES ~/.dotfiles
set -x VIMRC $HOME/.vimrc
set -x EDITOR /usr/bin/nvim
set -x MYVIMRC ~/.dotfiles/vim/.vimrc
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH
set -gx PATH ~/.cargo/bin $PATH
set -gx PATH ~/git-fuzzy/bin $PATH

if test -f /opt/dev/dev.fish
    source /opt/dev/dev.fish
end

if status is-interactive
  export ZELLIJ_CONFIG_DIR=$HOME/.config/zellij

  if [ "$TERM" = "xterm-ghostty" ] && command -v zellij >/dev/null
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
