# Makes it behaves like zsh's default
zstyle ':fzf-tab:*' query-string input prefix first
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# Enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:eza:*' fzf-preview '~/bin/.local/script/fzf-preview-view $realpath'
zstyle ':fzf-tab:complete:nvim:*' fzf-preview '~/bin/.local/script/fzf-preview-view $realpath'
