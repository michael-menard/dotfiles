#!/usr/bin/env bash
# prefix+shift+g -> open `wt switch` (worktree picker, create-if-needed) in a NEW
# herdr TAB in the focused workspace, instead of a split pane. herdr's
# [[keys.command]] has no native "tab" type, so we orchestrate it via the CLI.
#
# The tab self-closes when wt exits, so the transient picker host doesn't linger.
# The real per-worktree workspace is created separately by wt's `herdr-space`
# post-start hook. To keep the tab open instead, drop the trailing `herdr tab close`.
set -euo pipefail

ws=$(herdr workspace list \
  | python3 -c 'import sys,json; print(next((w["workspace_id"] for w in json.load(sys.stdin)["result"]["workspaces"] if w.get("focused")), ""))')
[ -n "$ws" ] || exit 0

read -r tab pane < <(herdr tab create --workspace "$ws" --label "wt" \
  | python3 -c 'import sys,json; r=json.load(sys.stdin)["result"]; print(r["tab"]["tab_id"], r["root_pane"]["pane_id"])')

herdr tab focus "$tab"
herdr pane run "$pane" "wt switch; herdr tab close $tab"
