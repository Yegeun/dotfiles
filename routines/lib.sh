# Sourced by setup-routines.sh and routines/status.

# Prints the first folder matching the pattern under $HOME that holds the script.
find_repo() {
    local pattern="$1" script="$2" dir
    for dir in "${HOME}"/$pattern; do
        if [ -f "${dir}/${script}" ]; then
            echo "$dir"
            return 0
        fi
    done
    return 1
}
