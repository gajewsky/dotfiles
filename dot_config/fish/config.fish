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

    # Auto-rename tab on prompt (not on PWD change)
    # Using fish_prompt ensures rename only happens when actively at a prompt,
    # preventing background tabs/scripts from renaming the wrong tab
    set -g __zellij_last_tab_name ""

    function __zellij_auto_rename_tab --on-event fish_prompt
        set -l current_dir (basename $PWD)
        if test "$current_dir" = (basename $HOME)
            set current_dir "~"
        end

        # Skip if name hasn't changed (prevents duplicates)
        if test "$current_dir" = "$__zellij_last_tab_name"
            return
        end
        set -g __zellij_last_tab_name "$current_dir"

        command zellij action rename-tab "$current_dir" 2>/dev/null
    end

    # Rename tab based on running command (for SSH, etc.)
    function __zellij_rename_on_command --on-event fish_preexec
        set -l cmd (string split ' ' -- $argv[1])
        set -l base_cmd $cmd[1]

        # Handle SSH
        if test "$base_cmd" = "ssh"
            # Extract hostname from SSH command
            set -l ssh_host
            for arg in $cmd[2..-1]
                # Skip flags
                if not string match -q -- '-*' $arg
                    set ssh_host $arg
                    break
                end
            end
            if test -n "$ssh_host"
                # Remove user@ prefix if present
                set ssh_host (string replace -r '^.*@' '' $ssh_host)
                command zellij action rename-tab "ssh:$ssh_host" 2>/dev/null
            end
        # Handle Claude Code (direct or via devx)
        else if test "$base_cmd" = "claude"; or test "$base_cmd" = "devx" -a "$cmd[2]" = "claude"
            set -l current_dir (basename $PWD)
            if test "$current_dir" = (basename $HOME)
                set current_dir "~"
            end
            command zellij action rename-tab "֎ $current_dir" 2>/dev/null
        end
    end

    # Restore directory name when command exits
    function __zellij_restore_on_postexec --on-event fish_postexec
        set -l cmd (string split ' ' -- $argv[1])
        set -l base_cmd $cmd[1]

        # Restore tab name after SSH or Claude exits
        if test "$base_cmd" = "ssh" -o "$base_cmd" = "claude"
            __zellij_auto_rename_tab
        else if test "$base_cmd" = "devx" -a "$cmd[2]" = "claude"
            __zellij_auto_rename_tab
        end
    end

    # Also rename on shell startup
    __zellij_auto_rename_tab

    # Terminal Search Shortcuts:
    # Ctrl+S: Enter zellij scroll mode
    # Ctrl+F: Quick search in zellij
    # Alt+S: FZF search in terminal buffer
    # Ctrl+Alt+S: Smart context-aware search
end

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
