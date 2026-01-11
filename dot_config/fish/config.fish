source ~/.config/fish/aliases.fish

set fish_greeting
set -gx EDITOR nvim

# fzf.fish configuration
set -gx fzf_diff_highlighter delta --paging=never --width=20
set -gx fzf_preview_file_cmd bat --style=numbers --color=always
set -gx fzf_preview_dir_cmd eza --all --color=always

# Add homebrew to PATH for Apple Silicon Macs
if test -d /opt/homebrew/bin
    set -gx PATH /opt/homebrew/bin $PATH
end

set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH
set -gx PATH ~/.opencode/bin $PATH
set -gx PATH ~/.cargo/bin $PATH
set -gx PATH ~/git-fuzzy/bin $PATH
set -gx PATH ~/.bun/bin $PATH

if test -f /opt/dev/dev.fish
    source /opt/dev/dev.fish
end

set -gx ZELLIJ_CONFIG_DIR $HOME/.config/zellij

# Zellij configuration moved to conf.d/zellij.fish

if command -v mise >/dev/null
    mise activate fish | source
end

if command -v zoxide >/dev/null
    # Initialize zoxide with cd replacement
    zoxide init fish --cmd cd | source
end

if command -v try >/dev/null
    env SHELL=(command -v fish) try init ~/src/tries | source
end



if status is-interactive
    # Disable flow control to allow ctrl+s and ctrl+q to work in terminal apps
    stty -ixon -ixoff 2>/dev/null

    starship init fish | source

    # Use different zellij theme for SSH sessions
    if test -n "$SSH_CONNECTION"
        set -gx ZELLIJ_CONFIG_OPTIONS "theme gruvbox-dark-ssh"
    end

    if [ "$TERM" = "xterm-ghostty" ]
        eval (zellij setup --generate-auto-start fish | string collect)
    end
end
