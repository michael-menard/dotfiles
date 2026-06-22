#!/usr/bin/env bash
# Zellij floating-pane menu. Bound to Ctrl p → ? in ~/.config/zellij/config.kdl.
# An fzf picker (with live preview) that routes to one of:
#   - Zellij commands  → cheatsheet.sh        (keybind quick-reference)
#   - Roadmap          → gh/initiative-modal.sh (initiative tree viewer, also Alt i)
#   - Workflow         → workflow-cheatsheet.sh (dev-loop skills quick-reference)
# Selecting a view runs it, then returns here; Esc/Ctrl-c on the menu closes the pane.
set -uo pipefail

# Make fzf / gh / less findable regardless of the env zellij inherited.
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

DIR="/Users/michaelmenard/.config/zellij"
GH_DIR="/Users/michaelmenard/.config/gh"

# `menu.sh --preview <label>` renders the right-hand fzf preview for a given row.
if [ "${1:-}" = "--preview" ]; then
  case "${2:-}" in
    *Zellij*)  bash "$DIR/cheatsheet.sh" --no-wait ;;
    *Roadmap*)
      cyan=$'\e[36m'; bold=$'\e[1m'; dim=$'\e[2m'; rst=$'\e[0m'
      printf '\n  %s%sROADMAP — INITIATIVES%s\n' "$bold" "$cyan" "$rst"
      printf '  %s─────────────────────────────────%s\n\n' "$dim" "$rst"
      printf '  Opens the initiative viewer:\n'
      printf '  an fzf picker of open initiatives\n'
      printf '  with a live tree preview, then the\n'
      printf '  chosen tree in a scrollable pager.\n\n'
      printf '  %sAlso bound directly to Alt i.%s\n' "$dim" "$rst"
      ;;
    *Workflow*) bash "$DIR/workflow-cheatsheet.sh" --no-wait ;;
  esac
  exit 0
fi

while true; do
  choice="$(
    printf '%s\n' \
      '  Zellij commands' \
      '  Roadmap (initiatives)' \
      '  Workflow commands' \
    | fzf --ansi \
          --prompt='menu › ' \
          --header='↑/↓ select · Enter open · Esc close' \
          --layout=reverse \
          --border=rounded \
          --preview="bash '$DIR/menu.sh' --preview {}" \
          --preview-window='right,55%,border-left'
  )" || exit 0
  [ -n "$choice" ] || exit 0

  case "$choice" in
    *Zellij*)   bash "$DIR/cheatsheet.sh" ;;
    *Roadmap*)  bash "$GH_DIR/initiative-modal.sh" ;;
    *Workflow*) bash "$DIR/workflow-cheatsheet.sh" ;;
  esac
done
