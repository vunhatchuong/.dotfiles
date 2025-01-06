# man zshparam
export KEYTIMEOUT=1           # Reduce input lag
bindkey -e                    # Disable vim-mode, breaks term in nvim

autoload -Uz plug

autoload -Uz colors && colors

setopt NO_BEEP                # Disable bell
setopt NOMATCH                # Throw error if no files match pattern
setopt INTERACTIVE_COMMENTS   # Allow comments even in interactive shells.
unsetopt CASE_GLOB            # Disable case sensitivity in globbing
unsetopt CASE_MATCH           # Disable case sensitivity in pattern matching

setopt correct                # Use CORRECT_IGNORE to ignore words
# setopt correctall
SPROMPT="Correct %B%F{red}%U%R%b%f%u to %F{green}%r%f? [%By/%Bn/%Be/%Ba]: "
