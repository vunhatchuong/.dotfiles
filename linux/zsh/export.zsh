HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=10000

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
