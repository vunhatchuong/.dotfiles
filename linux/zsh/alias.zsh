#!/bin/bash
# Aliases
# For a full list of active aliases, run `alias`.
#
alias cl="clear"

alias eza="eza --color=always --icons --time-style=long-iso"
alias ls="eza"
alias ll="ls -la --header"
alias la="ls -a"
alias tree="eza --tree --level=2 --group-directories-first"

alias less="less -R"
alias lg="lazygit"
alias lzd="lazydocker"
alias br="br -c :open_preview"

alias cat="bat"
alias vim="nvim"
alias god="go mod"

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias nvimrc='nvim ~/.config/nvim/'

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# easier to read disk
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB

# get top process eating memory
alias psmem='ps auxf | sort -nr -k 4 | head -5'

# get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3 | head -5'
