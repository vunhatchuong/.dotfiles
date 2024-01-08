[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

# Load colors so we can access $fg and more.
autoload -U colors && colors

# Disable CTRL-s from freezing your terminal's output.
stty stop undef

plug "zap-zsh/supercharge"

plug "$ZDOTDIR/export.zsh"

plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/vim"
plug "zap-zsh/fzf"
plug "zap-zsh/exa"
#plug "esc/conda-zsh-completion"
# Put it before the plugin
plug "catppuccin_mocha-zsh-syntax-highlighting"
plug "MichaelAquilina/zsh-you-should-use"

plug "$ZDOTDIR/alias.zsh"
plug "$ZDOTDIR/git.plugin.zsh"
#plug "$ZDOTDIR/conda.zsh"
plug "$ZDOTDIR/keymap.zsh"

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

# Must be at the end of the file
plug "zsh-users/zsh-syntax-highlighting"
