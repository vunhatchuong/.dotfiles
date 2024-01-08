#!/bin/bash
# Aliases
# For a full list of active aliases, run `alias`.
#
# Color ls, required exa plugin
alias eza="eza --color=auto --icons --time-style=long-iso"
alias ls="eza"
alias ll="eza -la"
alias la="ls --long --all --header --icons"
alias tree="eza --tree --level=2 --group-directories-first"

alias fd="fdfind"
alias less="less -R"
#alias anaconda="source $HOME/.config/zsh/conda.zsh"
alias lg="lazygit"
alias lzd="lazydocker"

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
