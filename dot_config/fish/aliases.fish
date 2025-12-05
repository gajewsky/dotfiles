# Eza (modern ls replacement)
alias ls 'eza'
alias ll 'eza -l --icons --git'
alias la 'eza -la --icons --git'
alias lt 'eza --tree --icons --level=2'
alias lta 'eza --tree --icons --level=2 -a'

# Bat (modern cat replacement)
alias cat 'bat'
alias catp 'bat --plain'

alias vim 'nvim'
alias reload! 'source ~/.config/fish/config.fish'
alias gapan 'git add --intent-to-add . && git add --patch'
alias git-branch-fzf "git branch -vv --color=always | fzf-tmux -d 15 --ansi | cut -c3- | cut -d' ' -f1"
alias gcob 'git checkout (git branch -a --color=always | grep -v "/HEAD\s" | fzf --ansi | sed "s/.*\///" | sed "s/^[* ]*//")'
alias gautours "git log --format='%aN' --since='3 months ago' -- . |sort | uniq -c | sort -nr"
alias gcmsg 'git commit -m'
alias gundo='git reset HEAD~'
alias speedtest-bytes 'wget -O /dev/null http://speedtest.tele2.net/10GB.zip'
alias speedtest-bits 'wget -O /dev/null http://speedtest.tele2.net/10GB.zip --report-speed=bits'

# Docker
alias remove_all_docker_containers="docker rm -vf (docker ps -a -q)"
alias remove_all_docker_images="docker rmi -f (docker images -a -q)"
alias dco 'docker-compose'
alias dce 'docker-compose exec'
alias dl 'docker ps -l -q'
alias dbe 'docker-compose run rails env bundle exec'

# MAC
alias cpu_temp 'sudo powermetrics --samplers smc |grep -i "CPU die temperature"'

# Zoxide
alias zq 'zoxide query'           # Query the database
alias zqi 'zoxide query -i'       # Interactive query
alias zr 'zoxide remove'          # Remove a path from database
alias za 'zoxide add'             # Manually add a path

# Interactive directory jump with fzf preview
function zf --description "Fuzzy find and jump to directory using zoxide + fzf"
    set -l result (zoxide query -l | fzf --height 40% --reverse --preview 'ls -la {}' --preview-window=right:40%)
    if test -n "$result"
        cd "$result"
    end
end
