# Git version checking
autoload -Uz is-at-least
git_version="${${(As: :)$(git version 2>/dev/null)}[3]}"

#
# Functions
#

# The name of the current branch
# Back-compatibility wrapper for when this function was defined here in
# the plugin, before being pulled in to core lib/git.zsh as git_current_branch()
# to fix the core -> git plugin dependency.
function current_branch() {
  git_current_branch
}

# Pretty log messages
function _git_log_prettily(){
  if ! [ -z $1 ]; then
    git log --pretty=$1
  fi
}
compdef _git _git_log_prettily=git-log

# Warn if the current branch is a WIP
function work_in_progress() {
  command git -c log.showSignature=false log -n 1 2>/dev/null | grep -q -- "--wip--" && echo "WIP!!"
}

# Check if main exists and use instead of master
function git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local ref
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk}; do
    if command git show-ref -q --verify $ref; then
      echo ${ref:t}
      return
    fi
  done
  echo master
}

# Check for develop and similarly named branches
function git_develop_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local branch
  for branch in dev devel development; do
    if command git show-ref -q --verify refs/heads/$branch; then
      echo $branch
      return
    fi
  done
  echo develop
}

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

#
# Aliases
#

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

alias glo='git log --oneline --decorate'
alias glog='git log --oneline --decorate --graph'
# Can add any additional flags like `glp --all`
alias glp="pretty_git_log"

alias gwt="git worktree"
alias gwtls="git worktree list"
alias gwta="git worktree add"
alias gwtrm="git worktree remove"
alias gwtmv="git worktree move"

alias gstl="git stash list"
alias gstp="git stash pop"
alias gstd="git stash drop"

function grename() {
  if [[ -z "$1" || -z "$2" ]]; then
    echo "Usage: $0 old_branch new_branch"
    return 1
  fi

  # Rename branch locally
  git branch -m "$1" "$2"
  # Rename branch in origin remote
  if git push origin :"$1"; then
    git push --set-upstream origin "$2"
  fi
}

unset git_version
