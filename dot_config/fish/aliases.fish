# Abbreviations (expand inline, more efficient than aliases)
# Simple commands - use abbreviations
abbr -a ls 'eza'
abbr -a ll 'eza -l --icons --git'
abbr -a lt 'eza --tree --icons --level=2'
abbr -a cat 'bat'
abbr -a catp 'bat --plain'
abbr -a vim 'nvim'

# Git extras (plugin-git provides: gst, gco, gcm, gp, gl, grbi, gsta, etc.)
abbr -a gundo 'git reset HEAD~'
abbr -a lg 'lazygit'
abbr -a grecent 'git recent'
abbr -a gcleanup 'git cleanup'
abbr -a gabsorb 'git absorb'

# Docker (V2 syntax)
abbr -a dco 'docker compose'
abbr -a dce 'docker compose exec'
abbr -a dl 'docker ps -l -q'

# Zoxide
abbr -a zq 'zoxide query'
abbr -a zqi 'zoxide query -i'
abbr -a zr 'zoxide remove'
abbr -a za 'zoxide add'

# Chezmoi
abbr -a dotfiles 'cd (chezmoi source-path)'

# fd (find replacement)
abbr -a ff 'fd --type f'
abbr -a fdir 'fd --type d'

# ripgrep
abbr -a rg 'rg --smart-case'

# procs (ps replacement)
abbr -a ps 'procs'
abbr -a pst 'procs --tree'

# bottom (htop replacement)
abbr -a top 'btm'
abbr -a htop 'btm'

# Functions (for complex commands with pipes/subshells)
function reload! --description "Reload fish config"
    source ~/.config/fish/config.fish
end

function gapan --description "Git add intent-to-add + patch"
    git add --intent-to-add . && git add --patch
end

function gcob --description "Git checkout branch with fzf"
    set -l branch (git branch -a --color=always | grep -v "/HEAD\s" | fzf --ansi | sed "s/.*\///" | sed "s/^[* ]*//")
    if test -n "$branch"
        git checkout $branch
    end
end

