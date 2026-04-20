if status is-interactive
    # Disable flow control to allow ctrl+s and ctrl+q to work in terminal apps.
    stty -ixon -ixoff 2>/dev/null

    # Use a different zellij theme for SSH sessions.
    if test -n "$SSH_CONNECTION"
        set -gx ZELLIJ_CONFIG_OPTIONS "theme gruvbox-dark-ssh"
    else
        set -e ZELLIJ_CONFIG_OPTIONS
    end

    if test "$TERM" = "xterm-ghostty"
        eval (zellij setup --generate-auto-start fish | string collect)
    end
end
