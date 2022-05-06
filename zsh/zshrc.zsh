[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit ice pick"async.zsh" src"pure.zsh"

zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust \
    zsh-users/zsh-autosuggestions \
    zdharma-continuum/fast-syntax-highlighting \
    sindresorhus/pure \
    olets/zsh-abbr

zinit snippet OMZ::plugins/git/git.plugin.zsh

alias gapan='git add --intent-to-add . && git add --patch'
alias gundo='git reset HEAD~'
alias ggp!='ggp --force-with-lease'
alias ls 'exa -a'
alias cat 'bat'
alias vim 'nvim'
alias reload! 'source ~/.config/fish/config.fish'
alias git-branch-fzf "git branch -vv --color=always | fzf-tmux -d 15 --ansi | cut -c3- | cut -d' ' -f1"
alias gcob 'git checkout (git-branch-fzf)'
alias gcmsg 'git commit -m'
alias t='trans'
