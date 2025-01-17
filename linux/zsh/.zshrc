[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

# Load colors so we can access $fg and more.
autoload -U colors && colors

# Disable CTRL-s from freezing your terminal's output.
stty stop undef

plug "$ZDOTDIR/general.zsh"
plug "$ZDOTDIR/export.zsh"
plug "$ZDOTDIR/completion.zsh"

plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/fzf"
plug "zap-zsh/exa"
plug "esc/conda-zsh-completion"
plug "Bhupesh-V/ugit"
plug "zap-zsh/sudo"

# This seems to bug out `Ctrl+` keymaps
# plug "jeffreytse/zsh-vi-mode"
# ZVM_CURSOR_STYLE_ENABLED=false

# fzf-tab
plug "Aloxaf/fzf-tab"
plug "Freed-Wu/fzf-tab-source"
plug "$ZDOTDIR/fzf-tab.zsh"

# Language Specific

# Put it before the plugin
plug "catppuccin_mocha-zsh-syntax-highlighting.zsh"
plug "MichaelAquilina/zsh-you-should-use"

plug "$ZDOTDIR/alias.zsh"
plug "$ZDOTDIR/git.plugin.zsh"
plug "$ZDOTDIR/conda.zsh"
plug "$ZDOTDIR/keymap.zsh"
plug "$ZDOTDIR/function.zsh"

if pgrep -u "$USER" gpg-agent > /dev/null 2>&1; then
    unset SSH_AGENT_PID
    if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
    fi
    export GPG_TTY=$(tty)
    gpg-connect-agent updatestartuptty /bye >/dev/null
fi

# Must be at the end of the file
plug "zsh-users/zsh-syntax-highlighting"

if [[ -t 1 ]]; then
    export GPG_TTY=$(tty)
fi

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

if command -v vfox >/dev/null; then
    eval "$(vfox activate zsh)"
fi
