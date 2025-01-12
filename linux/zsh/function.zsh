# Function to filter ports
# To list all ports: port
# Filter by states: port LISTEN
# Filter by state and port: port LISTEN 8080
function port() {
    local state ports port_filter=""

    # Check if the first argument is a valid state
    if [[ $# -gt 0 && "$1" =~ ^(LISTEN|ESTABLISHED|CLOSE_WAIT|SYN_SENT|TIME_WAIT)$ ]]; then
        state=$1
        shift  # Remove the state argument
    fi

    ports=("$@")  # Remaining arguments are treated as ports

    # Build the port filter if ports are specified
    if [[ ${#ports[@]} -gt 0 ]]; then
        port_filter=":${ports[*]}"
    fi

    if [[ -z $state ]]; then
        # No state filter
        lsof -nP -iTCP"$port_filter"
    else
        # With state filter
        lsof -nP -iTCP"$port_filter" -sTCP:$state
    fi
}


# https://github.com/mong8se/actually.fish
_actually() {
    local last_status=$?
    if (( last_status == 0 )); then
        return 0
    fi

  # Get the last executed command
    local last_cmd
    last_cmd=(${(z)$(fc -ln -1)})
    if [[ ${last_cmd[1]} != "cd" ]]; then
        return $last_status
    fi


    # Perform tilde expansion manually
    local last_dir last_base
    last_dir=$(dirname "${last_cmd[2]//~/$HOME}")
    last_base=$(basename "${last_cmd[2]}")

    local list=($(find "$last_dir" -maxdepth 1 -mindepth 1 -type d -iname "$last_base"'*' | sort))

    if [[ ${#list[@]} -eq 0 ]]; then
        return $last_status
    fi

    # Selection
    local destination
    if command -v fzf &>/dev/null; then
        local preview
    if command -v eza &>/dev/null; then
        preview='eza -1 --color=always {}'
    else
        preview='ls -F --color=auto {}'
    fi
        destination=$(printf '%s\0' "${list[@]}" | fzf --read0 --layout reverse --tiebreak=begin --preview="$preview")
    else
        for i in "${!list[@]}"; do
            echo "$((i + 1)) ${list[i]}"
        done
        echo -ne "\e[32m> \e[0m"
        read -r answer
            if [[ $answer =~ ^[0-9]+$ ]] && (( answer > 0 && answer <= ${#list[@]} )); then
                destination="${list[answer - 1]}"
            fi
    fi

    if [[ -d $destination ]]; then
        clear
        cd "$destination" || return $last_status
    else
        return $last_status
    fi
}

# Attach Zsh hook
autoload -Uz add-zsh-hook
add-zsh-hook precmd _actually

flakify() {
  if [ ! -e flake.nix ]; then
    nix flake new -t "$HOME/.dotfiles" .
  elif [ ! -e .envrc ]; then
    echo "use flake" > .envrc
  fi
  direnv allow
  ${EDITOR:-nvim} flake.nix
}
