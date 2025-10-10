#!/usr/bin/env zsh
set -euo pipefail

function main() {
    if ! command -v keymap &> /dev/null; then
        echo "Error: keymap-drawer is not installed or not in your PATH." >&2
        echo "Please install it from: https://github.com/caksoylar/keymap-drawer" >&2
        exit 1
    fi

    local __keymap_name="${1:-corne}"

    # Determine repo root via git
    local __repo_dir
    __repo_dir="$(git rev-parse --show-toplevel)"

    local __config_dir="$__repo_dir/config"
    local __output_dir="$__repo_dir/keymap-drawer"

    local __keymap_input_file="$__config_dir/${__keymap_name}.keymap"
    local __draw_config_file="$__config_dir/keymap-drawer.config.yml"
    local __parsed_yml_file="$__output_dir/${__keymap_name}.local.yml"
    local __output_svg_file="$__output_dir/${__keymap_name}.local.svg"

    echo "Parsing ZMK keymap: '$__keymap_input_file'"
    keymap -c "$__draw_config_file" parse -z "$__keymap_input_file" > "$__parsed_yml_file"

    echo "Drawing SVG to: '$__output_svg_file'"
    keymap -c "$__draw_config_file" draw "$__parsed_yml_file" > "$__output_svg_file"
}

main "$@"
