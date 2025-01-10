function pretty_git_log() {
  local HASH="%C(always,yellow)%h%C(always,reset)"
  local RELATIVE_TIME="%C(always,green)%ar%C(always,reset)"
  local AUTHOR="%C(always,bold blue)%an%C(always,reset)"
  local REFS="%C(always,red)%d%C(always,reset)"
  local SUBJECT="%s"

  local FORMAT="$HASH $RELATIVE_TIME{$AUTHOR{$REFS $SUBJECT"

  git log --graph --pretty="tformat:$FORMAT" "$@" | \
  column -t -s '{' | \
  less -XRS --quit-if-one-screen
}

alias gr='git remote'
alias gra='git remote add'
alias grset='git remote set-url'
alias grv='git remote -v'

alias gst='git status'
alias ga='git add'
alias gaa='git add --all'

alias gcam='git commit -a -m'
alias gcmsg='git commit -m'

alias gl='git pull'
alias gm='git merge'

alias gb='git branch'
alias gba='git branch -a'

alias gc='git clone'
alias gco='git checkout'
alias gcb='git checkout -b'

alias gd='git diff'
alias gdc='git diff --cached'

alias gp='git push'
alias gpd='git push --dry-run'

# alias glo='git log --oneline --decorate'
alias glog='git log --oneline --decorate --graph'
# Can add any additional flags like `glp --all`
alias glo="pretty_git_log"

alias gwt="git worktree"
alias gwtls="git worktree list"
alias gwta="git worktree add"
alias gwtrm="git worktree remove"
alias gwtmv="git worktree move"

alias gstl="git stash list"
alias gstp="git stash pop"
alias gstd="git stash drop"
