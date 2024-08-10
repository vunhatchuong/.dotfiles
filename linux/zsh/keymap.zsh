bindkey '^H' backward-kill-word # Ctrl + Backspace to delete a whole word.

# Use hjlk in menu selection during completion
# Doesn't work well with interactive mode
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char

bindkey -s "^f" "tmux-sessionizer\n"

# Ctrl-z to both suspend and start, don't have to type fg
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line -w
  else
    zle push-input -w
    zle clear-screen -w
  fi
}
zle -N fancy-ctrl-z
bindkey "^Z" fancy-ctrl-z
