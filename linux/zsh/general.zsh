autoload -Uz plug

autoload -Uz colors && colors

setopt NO_BEEP                # Disable bell
setopt NOMATCH                # Throw error if no files match pattern
setopt INTERACTIVE_COMMENTS   # Allow comments even in interactive shells.
unsetopt CASE_GLOB            # Disable case sensitivity in globbing
unsetopt CASE_MATCH           # Disable case sensitivity in pattern matching
