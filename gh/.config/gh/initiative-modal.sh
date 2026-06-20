#!/usr/bin/env bash
# Zellij floating-pane "modal" for the Initiative viewer.
# Flow: fzf picker (with live preview) → render the chosen tree in a scrollable pager → close.
# Bound to Alt i in ~/.config/zellij/config.kdl; also runnable via `zellij run --floating`.
set -uo pipefail

# Make gh / fzf / less findable regardless of the env zellij inherited.
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

# Force color: this runs in a real Zellij pane, but the tree is captured via $(...) (a pipe),
# so the TTY auto-detect would turn color off. less -R renders the ANSI.
export INITIATIVE_COLOR=1

# `gh initiative` with no arg = fzf picker (UI on /dev/tty); the selected tree goes to stdout.
sel="$(gh initiative "$@")" || exit 0
[ -n "$sel" ] || exit 0           # cancelled (esc) — just close the modal

# Scrollable final view; q closes the pager → close_on_exit closes the floating pane.
printf '%s\n' "$sel" | less -R --quit-if-one-screen --no-init
