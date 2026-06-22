#!/usr/bin/env bash
# Dev-workflow quick-reference cheat sheet (meant to run in a floating pane).
# Reflects this repo's Claude Code skills + git workflow (see CLAUDE.md → Git).
#
# --no-wait: print and exit immediately (used by menu.sh's fzf preview).
#            Default: clear the screen and wait for a keypress before closing.

wait=1
[ "${1:-}" = "--no-wait" ] && wait=0

[ "$wait" = 1 ] && clear
cyan=$'\e[36m'; bold=$'\e[1m'; dim=$'\e[2m'; grn=$'\e[32m'; yel=$'\e[33m'; rst=$'\e[0m'

cat <<EOF

  ${bold}${cyan}DEV WORKFLOW — QUICK REFERENCE${rst}
  ${dim}─────────────────────────────────────────────────${rst}

  ${bold}PLAN${rst}
    Brainstorm flows ${grn}/pm brainstorm${rst} ${dim}map every user flow (front door)${rst}
    Grill the plan   ${grn}/grill-me${rst}     ${dim}stress-test a design until it holds${rst}
    Groom backlog    ${grn}/groom${rst}        ${dim}reprioritize, anti-inflation caps${rst}
    Product manager  ${grn}/pm${rst}           ${dim}break down epics, refine ACs${rst}
    New initiative   ${grn}/new-initiative${rst} ${dim}cross-epic capability${rst}
    New epic         ${grn}/new-epic${rst}     ${dim}one shippable vertical slice${rst}
    New story        ${grn}/new-story${rst}    ${dim}Given/When/Then, autonomous-ready${rst}
    Split / size     ${grn}/split-story${rst} · ${grn}/size-story${rst}

  ${bold}BUILD${rst}
    Start a story    ${grn}/epic-start <story#>${rst} ${dim}board-gated: WIP-cap·worktree·zellij${rst}
      ↳ auto-pick    ${grn}epic-start frontier <epic#>${rst} ${dim}highest-pri unblocked child${rst}
      ↳ headless     ${grn}epic-start start <story#> --detached${rst} ${dim}no TTY attach${rst}
    New worktree     ${grn}/wt-switch-create <branch> -- <task>${rst} ${dim}lower-level (no cap)${rst}
    Verify change    ${grn}/verify${rst}       ${dim}run the app, observe behavior${rst}
    Review diff      ${grn}/code-review${rst}  ${dim}add ultra for cloud multi-agent${rst}
    Simplify diff    ${grn}/simplify${rst}

  ${bold}SHIP${rst}  ${dim}("done" means MERGED, not pushed)${rst}
    Finalize PR      ${yel}/pr-ready${rst}     ${dim}commit·push·rebase·ready·auto-merge${rst}
    Finish + merge   ${yel}/done${rst}         ${dim}gated exit, tear down worktree + session${rst}
    After merge      ${yel}/post-merge${rst}   ${dim}close story, reconcile epic${rst}
    PR comments      ${yel}/pr-comments <#>${rst}

  ${dim}─────────────────────────────────────────────────${rst}
  ${dim}Press any key to close.${rst}

EOF

[ "$wait" = 1 ] && read -rsn1 _
exit 0
