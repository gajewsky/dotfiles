function fisher_update
    # Check if fisher is installed
    if not type -q fisher
        # Install fisher
        echo "Fisher not found. Installing..."
        curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher && fisher update
    else
        # Update fisher
        echo "Fisher found. Updating..."
        fisher update
    end
end
