#!/bin/bash

export HISTFILE=~/.zsh_history
export HISTSIZE=50000
export SAVEHIST=10000

## History command configuration
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt HIST_IGNORE_ALL_DUPS  # Never add duplicate entries.
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data
setopt HIST_REDUCE_BLANKS    # Remove unnecessary blank lines.

VIM="nvim"

# FZF Catppuccin theme
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(vfox activate zsh)"
