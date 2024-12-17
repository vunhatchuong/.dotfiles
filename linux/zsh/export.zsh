#!/bin/bash

export HISTFILE=~/.zsh_history
export HISTSIZE=50000
export SAVEHIST=10000

## History command configuration
setopt EXTENDED_HISTORY         # Write the history file in the ":start:elapsed;command" format.
setopt BANG_HIST                # Treat the '!' character specially during expansion.
setopt HIST_EXPIRE_DUPS_FIRST   # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt HIST_IGNORE_DUPS         # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS     # Never add duplicate entries.
setopt HIST_FIND_NO_DUPS        # Do not display a line previously found.
setopt HIST_IGNORE_SPACE        # Ignore commands that start with space
setopt HIST_SAVE_NO_DUPS        # Don't write duplicate entries in the history file.
setopt HIST_VERIFY              # Show command with history expansion to user before running it
setopt SHARE_HISTORY            # Share history between all sessions.
setopt HIST_REDUCE_BLANKS       # Remove unnecessary blank lines.
setopt APPEND_HISTORY

# FZF Catppuccin theme
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--cycle"

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(vfox activate zsh)"
