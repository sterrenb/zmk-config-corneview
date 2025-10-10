#!/usr/bin/env zsh

REPO_DIR="$(git rev-parse --show-toplevel)"
WATCH_DIR="$REPO_DIR/config"
SCRIPT_DIR="$REPO_DIR/scripts"

"$SCRIPT_DIR/draw.zsh"

# Get the last modification timestamp of the entire directory
last_mod=$(find "$WATCH_DIR" -type f -exec stat -c %Y {} + | sort -n | tail -1)

while true; do
    sleep 1
    # Get current latest modification timestamp
    new_mod=$(find "$WATCH_DIR" -type f -exec stat -c %Y {} + | sort -n | tail -1)
    
    if [[ $new_mod -ne $last_mod ]]; then
        last_mod=$new_mod
        "$SCRIPT_DIR/draw.zsh"
    fi
done