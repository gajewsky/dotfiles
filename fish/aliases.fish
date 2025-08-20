alias vim 'nvim'
alias reload! 'source ~/.config/fish/config.fish'
alias gapan 'git add --intent-to-add . && git add --patch'
alias git-branch-fzf "git branch -vv --color=always | fzf-tmux -d 15 --ansi | cut -c3- | cut -d' ' -f1"
alias gcob 'git checkout (git-branch-fzf)'
alias ghprl="GH_FORCE_TTY=100% gh pr list --author \"@me\" | fzf --ansi --preview 'GH_FORCE_TTY=100% gh pr view {1}' --header-lines 4 | awk '{print $1}' | xargs gh pr checkout"
alias gautours "git log --format='%aN' --since='3 months ago' -- . |sort | uniq -c | sort -nr"
alias gcmsg 'git commit -m'
alias gundo='git reset HEAD~'
alias t='trans'
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
