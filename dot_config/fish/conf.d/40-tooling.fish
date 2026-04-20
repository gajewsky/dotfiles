if test -f /opt/dev/dev.fish
    source /opt/dev/dev.fish
end

if command -q mise
    mise activate fish | source
end

if command -q zoxide
    # Initialize zoxide with cd replacement.
    zoxide init fish --cmd cd | source
end
