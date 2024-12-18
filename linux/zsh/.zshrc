[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

if [[ -n $WSLENV ]]; then
    # Turn off blink cursor if WSL: https://github.com/microsoft/terminal/issues/1379
    printf '\e[?12l'
fi

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
plug "MichaelAquilina/zsh-auto-notify"

plug "$ZDOTDIR/alias.zsh"
plug "$ZDOTDIR/git.plugin.zsh"
plug "$ZDOTDIR/conda.zsh"
plug "$ZDOTDIR/keymap.zsh"

# Must be at the end of the file
plug "zsh-users/zsh-syntax-highlighting"
