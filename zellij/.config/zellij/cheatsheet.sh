#!/usr/bin/env bash
# Zellij quick-reference cheat sheet (meant to run in a floating pane).
# Reflects this machine's config: Ctrl-p pane-mode is unbound; pane actions
# are rebound to direct Alt keys (see config.kdl shared_except block).
#
# --no-wait: print and exit immediately (used by menu.sh's fzf preview).
#            Default: clear the screen and wait for a keypress before closing.

wait=1
[ "${1:-}" = "--no-wait" ] && wait=0

[ "$wait" = 1 ] && clear
cyan=$'\e[36m'; bold=$'\e[1m'; dim=$'\e[2m'; grn=$'\e[32m'; yel=$'\e[33m'; rst=$'\e[0m'

cat <<EOF

  ${bold}${cyan}ZELLIJ — QUICK REFERENCE${rst}
  ${dim}─────────────────────────────────────────────────${rst}

  ${bold}SESSIONS${rst}
    New session      ${grn}zellij -s <name>${rst}   ${dim}(or Ctrl o → w)${rst}
    Kill session     ${grn}zellij kill-session <name>${rst}
    Detach           ${yel}Ctrl o${rst} → ${yel}d${rst}
    Session manager  ${yel}Ctrl o${rst} → ${yel}w${rst}

  ${bold}TABS${rst}
    New tab          ${yel}Ctrl t${rst} → ${yel}n${rst}
    Kill tab         ${yel}Ctrl t${rst} → ${yel}x${rst}
    Rename tab       ${yel}Ctrl t${rst} → ${yel}r${rst} → type → ${yel}Enter${rst}
    Next / prev tab  ${yel}Ctrl t${rst} → ${yel}→ / ←${rst}

  ${bold}PANES${rst}  ${dim}(Ctrl p enters pane mode)${rst}
    Split right      ${yel}Ctrl p${rst} → ${yel}r${rst}
    Split down       ${yel}Ctrl p${rst} → ${yel}d${rst}
    New pane (auto)  ${yel}Ctrl p${rst} → ${yel}n${rst}
    Kill pane        ${yel}Ctrl p${rst} → ${yel}x${rst}
    Fullscreen       ${yel}Ctrl p${rst} → ${yel}f${rst}
    Float toggle     ${yel}Ctrl p${rst} → ${yel}w${rst}
    Move focus       ${yel}Ctrl p${rst} → ${yel}h / j / k / l${rst}
    This cheat sheet ${yel}Ctrl p${rst} → ${yel}?${rst}

  ${dim}─────────────────────────────────────────────────${rst}
  ${dim}Press any key to close.${rst}

EOF

[ "$wait" = 1 ] && read -rsn1 _
exit 0
