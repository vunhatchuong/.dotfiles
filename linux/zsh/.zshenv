if [[ -n $WSLENV ]]; then
    # Turn off blink cursor if WSL: https://github.com/microsoft/terminal/issues/1379
    printf '\e[?12l'
fi

# FZF Catppuccin theme
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--color=gutter:-1 \
--cycle"

export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/config"

export LESSOPEN="| bat --paging=always --decorations=always %s"
export LESS="-R"
export PAGER="bat"
export BAT_PAGER="less -R"

export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"
