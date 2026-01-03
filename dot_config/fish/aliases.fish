# Command replacements (transparent - use alias)
alias ls='eza'
alias ll='eza -l --icons --git'
alias lt='eza --tree --icons --level=2'
alias cat='bat'
alias catp='bat --plain'
alias vim='nvim'

# Git extras (plugin-git provides: gst, gco, gcm, gp, gl, grbi, gsta, etc.)
abbr -a gcmsg 'git commit -m'
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

# Graphite (only if installed)
if command -q gt
    # Navigation
    abbr -a gtco 'gt checkout'
    abbr -a gtg 'gt get'
    abbr -a gtk 'gt checkout trunk'

    # Creating/committing
    abbr -a gtc 'gt create -am'
    abbr -a gtcn 'gt create --no-verify'
    abbr -a gtcm 'gt commit -m'
    abbr -a gtmsg 'gt commit -m'

    # Submitting PRs
    abbr -a gts 'gt submit --stack --update-only'
    abbr -a gtss 'gt submit --stack'

    # Viewing stack
    abbr -a gtl 'gt log short'
    abbr -a gtll 'gt log long'
    abbr -a gtlo 'gt log'
    abbr -a gtls 'gt log short -s'
    abbr -a gtlc 'gt log --classic'
end

# procs (ps replacement)
alias ps='procs'
alias pst='procs --tree'

# bottom (htop replacement)
alias top='btm'
alias htop='btm'

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

function cb --description "Copy to clipboard (cross-platform)"
    if command -q pbcopy
        # macOS
        pbcopy
    else if command -q xclip
        # Linux
        xclip -selection clipboard
    else
        echo "Error: No clipboard command found (pbcopy or xclip)" >&2
        return 1
    end
end

function use-zai --description "Switch Claude Code to use z.ai API"
    set -gx ANTHROPIC_BASE_URL "https://api.z.ai/api/anthropic"
    set -gx API_TIMEOUT_MS "3000000"
    echo "Claude Code now using z.ai API"
end

function use-claude --description "Switch Claude Code to use Anthropic API"
    set -e ANTHROPIC_BASE_URL
    set -e API_TIMEOUT_MS
    echo "Claude Code now using Anthropic API"
end

