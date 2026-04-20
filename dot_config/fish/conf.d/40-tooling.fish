if command -q mise
    mise activate fish | source
end

if command -q zoxide
    # Initialize zoxide with cd replacement.
    zoxide init fish --cmd cd | source
end
