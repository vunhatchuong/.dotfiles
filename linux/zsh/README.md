# ZSH Notes

## ZSH Files

Order of loading: `.zshenv → [.zprofile if login] → [.zshrc if interactive] → [.zlogin if login] → [.zlogout sometimes]`

When open a new window in tmux, `.zshenv`, `.zprofile` and `.zshrc` will all be loaded.

### Zshenv

This will always load no matter what, useful to apply options to one off commands (-c flag).

### Zprofile

This will only load when you login, this usually means changes will apply when you restart the machine.

### Zshrc

This will only load when you are in an interactive shell.
