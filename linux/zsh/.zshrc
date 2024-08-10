[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

# Load colors so we can access $fg and more.
autoload -U colors && colors

# Disable CTRL-s from freezing your terminal's output.
stty stop undef

plug "zap-zsh/supercharge"

plug "$ZDOTDIR/export.zsh"

plug "zap-zsh/completions"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/vim"
plug "zap-zsh/fzf"
plug "zap-zsh/exa"
plug "esc/conda-zsh-completion"
plug "Bhupesh-V/ugit"

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

# Must be at the end of the file
plug "zsh-users/zsh-syntax-highlighting"
