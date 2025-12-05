# FZF Configuration for Fish Shell

# Core FZF Options
set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -gx FZF_ALT_C_COMMAND 'fd --type d --hidden --follow --exclude .git'

# FZF Theme - Gruvbox Dark
# Based on the gruvbox color palette
set -gx FZF_DEFAULT_OPTS '
  --height 60%
  --border sharp
  --layout reverse
  --info inline
  --multi
  --preview-window "right:50%:wrap"
  --bind "ctrl-/:toggle-preview"
  --bind "ctrl-a:select-all"
  --bind "ctrl-y:execute-silent(echo {+} | pbcopy)"
  --bind "ctrl-e:execute(echo {+} | xargs -o nvim)"
  --bind "ctrl-v:execute(code {+})"
  --color=fg:#ebdbb2,bg:#282828,hl:#fabd2f
  --color=fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f
  --color=info:#83a598,prompt:#bdae93,pointer:#fb4934
  --color=marker:#fe8019,spinner:#fabd2f,header:#665c54
  --color=border:#3c3836,label:#ebdbb2,query:#ebdbb2
  --border="rounded" --border-label="" --preview-window="border-rounded"
  --prompt="> " --marker=">" --pointer="◆" --separator="─"
  --scrollbar="│"'


# Preview settings for different commands
set -gx FZF_CTRL_T_OPTS "
  --preview 'bat -n --color=always --line-range :500 {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

set -gx FZF_CTRL_R_OPTS "
  --preview 'echo {}'
  --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

set -gx FZF_ALT_C_OPTS "
  --preview 'eza --tree --color=always --level=2 --icons {}'"

# Configure fzf.fish keybindings
fzf_configure_bindings --directory=\ct --git_log=\cg --git_status=\cs --history=\cr --variables=\cv --processes=\cp

# Additional FZF Functions

# Quick cd to project directories
function p --description "Jump to project"
    set project_dir (fd --type d --max-depth 3 . ~/git ~/projects ~/code 2>/dev/null | \
        fzf --preview 'eza --tree --color=always --level=2 --icons {}' \
            --preview-window 'right:40%' \
            --header 'Jump to project')
    and cd $project_dir
end

# Git branch switcher with preview
function gb --description "Interactive git branch switcher"
    set branch (git branch -a --color=always | \
        grep -v '/HEAD\s' | \
        fzf --ansi --preview-window right:70% \
            --preview 'git log --oneline --graph --color=always --date=short --pretty="format:%C(auto)%cd %h%d %s" (echo {} | sed "s/.* //")' | \
        sed 's/^[* ]*//' | sed 's#remotes/##')
    and git checkout (echo $branch | sed 's#origin/##')
end

# Git commit browser
function gshow --description "Git commit browser"
    git log --graph --color=always \
        --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$argv" |
    fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
        --header "Press CTRL-S to toggle sort" \
        --preview 'echo {} | grep -o "[a-f0-9]\{7\}" | head -1 | xargs -I % git show --color=always %' \
        --bind "enter:execute:
            echo {} | grep -o '[a-f0-9]\{7\}' | head -1 |
            xargs -I % sh -c 'git show --color=always % | less -R'"
end

# Kill process
function fkill --description "Kill processes"
    set pid (ps aux | sed 1d | fzf -m --header='Kill process' | awk '{print $2}')
    if test -n "$pid"
        echo $pid | xargs kill -9
        echo "Killed processes: $pid"
    end
end

# Docker container management
function dsh --description "Docker shell into container"
    set container (docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}" | \
        sed 1d | fzf --header="Select container" | awk '{print $1}')
    and docker exec -it $container /bin/bash || docker exec -it $container /bin/sh
end

# NPM scripts runner
function nr --description "Run npm scripts"
    if test -f package.json
        set script (jq -r '.scripts | keys[]' package.json | \
            fzf --preview 'jq -r ".scripts.\"{}\"" package.json' \
                --preview-window up:2:wrap \
                --header 'Select npm script to run')
        and npm run $script
    else
        echo "No package.json found"
    end
end

# Improved file search with ripgrep
function rgi --description "Interactive ripgrep"
    set INITIAL_QUERY $argv
    set RG_PREFIX "rg --column --line-number --no-heading --color=always --smart-case "
    FZF_DEFAULT_COMMAND="$RG_PREFIX '$INITIAL_QUERY'" \
        fzf --bind "change:reload:$RG_PREFIX {q} || true" \
            --ansi --disabled --query "$INITIAL_QUERY" \
            --height=80% --layout=reverse \
            --header 'Ripgrep search | CTRL-E: open in editor' \
            --preview 'bat --color=always {1} --highlight-line {2}' \
            --preview-window 'up,60%,border-bottom,+{2}+3/3' \
            --bind 'ctrl-e:execute(nvim {1} +{2})'
end

# Z with fzf
if command -v zoxide >/dev/null
    function zi --description "Interactive zoxide"
        set result (zoxide query -l | fzf --preview 'eza --tree --color=always --level=2 --icons {}')
        and cd $result
    end
end

# Environment variable explorer
function envs --description "Search environment variables"
    env | fzf --preview 'echo {} | cut -d= -f2-' \
        --preview-window up:3:wrap \
        --bind 'ctrl-y:execute-silent(echo {} | cut -d= -f2- | pbcopy)+abort' \
        --header 'CTRL-Y to copy value'
end

# Homebrew formula info
if command -v brew >/dev/null
    function brewd --description "Brew formula details"
        set formula (brew formulae | fzf --preview 'brew info {}' --preview-window right:70%)
        and brew info $formula
    end
end
