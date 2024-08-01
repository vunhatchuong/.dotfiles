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
