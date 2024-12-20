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
