# Keep user paths ordered and avoid re-adding them on nested shells.
fish_add_path --path --move /opt/homebrew/bin
fish_add_path --path --move ~/bin ~/.local/bin ~/.opencode/bin ~/.cargo/bin ~/git-fuzzy/bin ~/.bun/bin $PNPM_HOME
