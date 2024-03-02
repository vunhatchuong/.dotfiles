zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:eza:*' fzf-preview '~/bin/.local/script/fzf-preview-view $realpath'
zstyle ':fzf-tab:complete:nvim:*' fzf-preview '~/bin/.local/script/fzf-preview-view $realpath'
