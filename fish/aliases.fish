alias ls='exa -a'
alias cat='bat'
alias vim='nvim'
alias reload!='source ~/.config/fish/config.fish'


# GIT

alias g='git'
alias gst='git status'
alias gd='git diff --color-words=.'
alias gdc='git diff --cached'
alias gl='git pull'
alias gp='git push'

function gdv
  git diff -w $argv | view -
end

alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gca='git commit -v -a'
alias gca!='git commit -v -a --amend'
alias gcmsg='git commit -m'
alias gco='git checkout'
alias gb='git branch'
alias gba='git branch -a'
alias gcount='git shortlog -sn'
alias gcl='git config --list'
alias gcp='git cherry-pick'
alias glg='git log --stat --max-count=10'
alias glgg='git log --graph --max-count=10'
alias glgga='git log --graph --decorate --all'
alias glo='git log --oneline'
alias gss='git status -s'
alias ga='git add'
alias gm='git merge'
alias gclean='git reset --hard; and git clean -dfx'
alias gwc='git whatchanged -p --abbrev-commit --pretty=medium'

alias gmt='git mergetool --no-prompt'
alias gsts='git stash show --text'
alias gsta='git stash'
alias gstp='git stash pop'
alias gstd='git stash drop'

alias gwip='git add -A; git ls-files --deleted -z | xargs -0 git rm; git commit -m "wip"'
alias gunwip='git log -n 1 | grep -q -c wip; and git reset HEAD~1'

alias gapan='git add --intent-to-add . && git add --patch'
alias git-branch-fzf="git branch -vv --color=always | fzf-tmux -d 15 --ansi | cut -c3- | cut -d' ' -f1"
alias gcob='git checkout (git-branch-fzf)'
