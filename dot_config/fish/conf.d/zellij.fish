# Zellij terminal multiplexer integration
# Auto-loaded when fish starts

# Rename Zellij session to current git worktree/repo name
# Available outside Zellij too (will just fail silently if not in Zellij)
function zellij-rename-session-to-worktree --description "Rename Zellij session to current git worktree name, or attach if session exists"
    # Check if we're in a git repo
    if not git rev-parse --git-dir >/dev/null 2>&1
        echo "Error: Not in a git repository"
        return 1
    end

    set -l git_dir (git rev-parse --git-dir 2>/dev/null)
    set -l toplevel (git rev-parse --show-toplevel 2>/dev/null)
    set -l worktree_name

    if test -f "$git_dir/commondir"
        # We're in a worktree - get parent of toplevel
        set worktree_name (basename (dirname "$toplevel"))
    else
        # Regular repo - use repo name
        set worktree_name (basename "$toplevel")
    end

    if test -z "$worktree_name"
        echo "Error: Could not determine worktree name"
        return 1
    end

    # Check if a session with this name already exists
    if command zellij list-sessions 2>/dev/null | string match -q "$worktree_name *"
        command zellij attach "$worktree_name"
    else if set -q ZELLIJ
        # Already inside Zellij - just rename current session
        command zellij action rename-session "$worktree_name"
        echo "✓ Session renamed to '$worktree_name'"
    else
        # Not inside Zellij - create a new session with that name
        command zellij --session "$worktree_name"
    end
end

abbr -a zrs 'zellij-rename-session-to-worktree'

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

    # Track manually-locked tabs (disable auto-rename)
    # Use universal variable to persist across shell instances
    if not set -q __zellij_locked_tabs
        set -U __zellij_locked_tabs
    end

    function __zellij_auto_rename_tab --on-event fish_prompt
        # Skip if auto-rename is disabled for this pane
        if set -q __zellij_autorename_disabled
            return
        end

        set -l current_dir (basename $PWD)
        if test "$current_dir" = (basename $HOME)
            set current_dir "~"
        end

        # Skip if name hasn't changed (prevents duplicates)
        if test "$current_dir" = "$__zellij_last_tab_name"
            return
        end
        set -g __zellij_last_tab_name "$current_dir"

        # Use nohup to prevent race conditions when multiple panes try to rename
        # This backgrounds the command and prevents concurrent rename conflicts
        nohup zellij action rename-tab "$current_dir" >/dev/null 2>&1 &
    end

    # Rename tab based on running command (for SSH, etc.)
    function __zellij_rename_on_command --on-event fish_preexec
        set -l cmd (string split ' ' -- $argv[1])
        set -l base_cmd $cmd[1]

        # Resolve devx wrapper: "devx claude" → base_cmd = "claude"
        if test "$base_cmd" = "devx"; and set -q cmd[2]
            set base_cmd $cmd[2]
        end

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
        # Handle Codex
        else if test "$base_cmd" = "codex"
            set -l current_dir (basename $PWD)
            if test "$current_dir" = (basename $HOME)
                set current_dir "~"
            end
            command zellij action rename-tab "֎ $current_dir" 2>/dev/null
        # Handle Claude
        else if test "$base_cmd" = "claude"
            set -l current_dir (basename $PWD)
            if test "$current_dir" = (basename $HOME)
                set current_dir "~"
            end
            command zellij action rename-tab "✳ $current_dir" 2>/dev/null
        # Handle OpenCode
        else if test "$base_cmd" = "opencode"
            set -l current_dir (basename $PWD)
            if test "$current_dir" = (basename $HOME)
                set current_dir "~"
            end
            command zellij action rename-tab "◌ $current_dir" 2>/dev/null
        # Handle Pi
        else if test "$base_cmd" = "pi"
            set -l current_dir (basename $PWD)
            if test "$current_dir" = (basename $HOME)
                set current_dir "~"
            end
            command zellij action rename-tab "𝞹 $current_dir" 2>/dev/null
        end
    end

    # Restore directory name when command exits
    function __zellij_restore_on_postexec --on-event fish_postexec
        set -l cmd (string split ' ' -- $argv[1])
        set -l base_cmd $cmd[1]

        # Resolve devx wrapper: "devx claude" → base_cmd = "claude"
        if test "$base_cmd" = "devx"; and set -q cmd[2]
            set base_cmd $cmd[2]
        end

        # Restore tab name after SSH or AI assistant exits
        if begin
            test "$base_cmd" = "ssh"
            or test "$base_cmd" = "codex"
            or test "$base_cmd" = "claude"
            or test "$base_cmd" = "opencode"
            or test "$base_cmd" = "pi"
        end
            __zellij_auto_rename_tab
        end
    end

    # Helper functions for manual rename control
    function zellij-lock-tab --description "Disable auto-rename for this tab/pane"
        set -g __zellij_autorename_disabled 1
        echo "✓ Auto-rename disabled for this pane. Use 'zellij-unlock-tab' to re-enable."
    end

    function zellij-unlock-tab --description "Re-enable auto-rename for this tab/pane"
        set -e __zellij_autorename_disabled
        echo "✓ Auto-rename enabled for this pane."
        __zellij_auto_rename_tab
    end

    function zellij-rename --description "Manually rename tab and disable auto-rename"
        if test (count $argv) -eq 0
            echo "Usage: zellij-rename <new-tab-name>"
            return 1
        end
        command zellij action rename-tab "$argv" 2>/dev/null
        set -g __zellij_autorename_disabled 1
        echo "✓ Tab renamed to '$argv'. Auto-rename disabled for this pane."
        echo "  Use 'zellij-unlock-tab' to re-enable auto-rename."
    end

    # Also rename on shell startup (unless locked)
    __zellij_auto_rename_tab

    # Terminal Search Shortcuts:
    # Ctrl+S: Enter zellij scroll mode
    # Ctrl+F: Quick search in zellij
    # Alt+S: FZF search in terminal buffer
    # Ctrl+Alt+S: Smart context-aware search
end
