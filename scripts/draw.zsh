#!/usr/bin/env zsh

set -euo pipefail

function main() {
  # Default to 'corne' if no argument is provided
  local __keymap_name="${1:-corne}"

  # Determine directory paths relative to the script's location
  local __repo_dir="$(dirname $(dirname $(realpath $0)))"
  local __config_dir="$__repo_dir/config"
  local __output_dir="$__repo_dir/keymap-drawer"

  # Define file paths
  local __keymap_input_file="$__config_dir/${__keymap_name}.keymap"
  local __draw_config_file="$__config_dir/keymap-drawer.config.yml"
  local __parsed_yml_file="$__output_dir/${__keymap_name}.local.yml"
  local __output_svg_file="$__output_dir/${__keymap_name}.local.svg"

  echo "Parsing ZMK keymap: '$__keymap_input_file'"
  keymap -c "$__draw_config_file" parse -z "$__keymap_input_file" > "$__parsed_yml_file"

  echo "Drawing SVG to: '$__output_svg_file'"
  keymap -c "$__draw_config_file" draw "$__parsed_yml_file" > "$__output_svg_file"

  echo "✅ Done."
}

main "$@"
