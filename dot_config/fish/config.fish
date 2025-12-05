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

if set -q ZELLIJ
    # Force proper terminal size reporting
    stty rows $LINES cols $COLUMNS 2>/dev/null

    # Disable flow control to allow ctrl+s in zellij
    stty -ixon -ixoff 2>/dev/null

    # Clear any existing postexec handlers
    functions -e fish_postexec

    # Reset terminal state before each prompt
    function __zellij_preexec --on-event fish_preexec
        printf "\033[?7h"  # Enable line wrap
    end

    function __zellij_prompt_reset --on-event fish_prompt
        # Ensure clean state before prompt
        printf "\033[0m\033[K\r"  # Reset attributes, clear line, return to start
    end

    function zt
        set current_dir (basename $PWD)
        if test "$current_dir" = (basename $HOME)
            set current_dir "~"
        end
        command zellij action rename-tab "$current_dir"
    end

    # Terminal Search Shortcuts:
    # Ctrl+S: Enter zellij scroll mode
    # Ctrl+F: Quick search in zellij
    # Alt+S: FZF search in terminal buffer
    # Ctrl+Alt+S: Smart context-aware search
end

if command -v zoxide >/dev/null
    zoxide init fish | source
end



if status is-interactive
    # Disable flow control to allow ctrl+s and ctrl+q to work in terminal apps
    stty -ixon -ixoff 2>/dev/null

    starship init fish | source
    export ZELLIJ_CONFIG_DIR=$HOME/.config/zellij
    if [ "$TERM" = "xterm-ghostty" ]
        eval (zellij setup --generate-auto-start fish | string collect)
    end
end
