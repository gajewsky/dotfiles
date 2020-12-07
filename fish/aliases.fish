alias ls 'exa -a'
alias cat 'bat'
alias vim 'nvim'
alias reload! 'source ~/.config/fish/config.fish'
alias gapan 'git add --intent-to-add . && git add --patch'
alias git-branch-fzf "git branch -vv --color=always | fzf-tmux -d 15 --ansi | cut -c3- | cut -d' ' -f1"
alias gcob 'git checkout (git-branch-fzf)'
alias gcmsg 'git commit -m'
alias gundo='git reset HEAD~'
alias gundo='git reset HEAD~'
alias t='trans'

alias dco 'docker-compose'
alias dce 'docker-compose exec'
alias dl 'docker ps -l -q'
alias dbe 'docker-compose run rails env bundle exec'
alias pbcopy 'xclip -selection clipboard'
alias pbpaste 'xclip -selection clipboard -o'
alias speedtest-bytes 'wget -O /dev/null http://speedtest.tele2.net/10GB.zip'
alias speedtest-bits 'wget -O /dev/null http://speedtest.tele2.net/10GB.zip --report-speed=bits'

# PACT
# run application/stop application
alias lhu "docker-compose -f docker-compose.yml -f docker-compose.app.yml up"
alias lhd "docker-compose -f docker-compose.yml -f docker-compose.app.yml down --remove-orphans"
alias lhb "docker-compose -f docker-compose.yml -f docker-compose.app.yml build"
alias lhr "docker-compose -f docker-compose.yml -f docker-compose.app.yml down --rmi local"

# same as above, but also run all services this service depends on
alias lhus "docker-compose -f docker-compose.yml -f docker-compose.app.yml -f docker-compose.services.yml up --abort-on-container-exit"
alias lhds "docker-compose -f docker-compose.yml -f docker-compose.app.yml -f docker-compose.services.yml down --remove-orphans"

alias remove_all_docker_containers="docker rm -vf (docker ps -a -q)"
alias remove_all_docker_images="docker rmi -f (docker images -a -q)"

function lh-kibana
  kubectx lh_production
  kubectl -n monitoring port-forward svc/kibana-kibana 5601:5601 &
  sleep 2
  open http://localhost:5601
end

function lhe
  docker exec -it (docker ps | grep -m 1 start_docker | awk '{print $1}') /bin/bash
end

function etvrepo
  cd (find ~/code/pact/* -type d -maxdepth 0 -print 2> /dev/null | fzf +m)
end

function lhservice
  set -l dir
  set dir (find ~/code/pact/lh-be-connected-factories/services/* -type d -maxdepth 0 -print 2> /dev/null | fzf +m) &&
  cd "$dir"
end

# Example usage:
# kexec bash
# kexec bin/maintenance cli

function kexec
  set PROMPT "Select pod to execute \"$argv\" (current context: `kubectl config current-context`): "
  set -l pod
  set pod (kubectl get pods | grep Running | awk '{ print $1 }' 2> /dev/null | fzf +m --prompt $PROMPT) &&

  kubectl exec -it $pod -- $argv
end

# Print the pod's logs (requires fzf being installed)
function klogs
  set -l pod
  set pod (kubectl get pods | awk '{ print $1 }' 2> /dev/null | fzf +m) &&
  kubectl logs -f $pod
end

function lhx
  if set -q argv[1]
    set command $argv
  else
    set command /bin/bash
  end
  docker exec -it -u (id -u):(id -g) (docker ps | grep -m 1 start_docker | awk '{print $1}') $command
end

function kdesc
  kubectl get po | fzf --header-lines=1 --multi --preview 'kubectl describe po {+1}' --bind 'ctrl-r:reload(kubectl get po)' --header 'Press CTRL-R to reload'
end



# CalincomeA
#
function cx
  if set -q argv[1]
    set command $argv
  else
    set command /bin/bash
  end
  docker exec -it -u (id -u):(id -g) (docker ps | grep -m 1 calincome-docker_app | awk '{print $1}') $command
end
