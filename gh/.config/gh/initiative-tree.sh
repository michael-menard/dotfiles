#!/usr/bin/env bash
# Print an Initiative's tree: initiative ▸ child epics ├─ → stories •
# Usage:
#   gh initiative                 # fzf picker — choose by name (no number needed)
#   gh initiative <text>          # pre-seed the picker filter, e.g. `gh initiative procure`
#   gh initiative <number>        # straight to that Initiative's tree
#   gh initiative --all  | -a     # every open Initiative's tree, in one shot
#   gh initiative --list | -l     # just the number→title list (no tree)
#
# Color: on when stdout is a TTY, or when INITIATIVE_COLOR=1 (the fzf preview + modal set it).
# Piped/captured (e.g. the /initiative skill) → plain text, no escape codes.
set -uo pipefail

export GH_INITIATIVE_OWNER="${GH_INITIATIVE_OWNER:-CodeFika}"
export GH_INITIATIVE_REPO="${GH_INITIATIVE_REPO:-monorepo}"
owner="$GH_INITIATIVE_OWNER"
repo="$GH_INITIATIVE_REPO"
self="$0"

list_initiatives() { # -> "NUMBER\tTITLE" per open Initiative
  gh issue list -R "$owner/$repo" --search 'type:Initiative state:open' \
    --limit 100 --json number,title --jq '.[] | "\(.number)\t\(.title)"'
}

print_tree() {
  local color=0
  if [ -t 1 ] || [ "${INITIATIVE_COLOR:-0}" = "1" ]; then color=1; fi
  gh api graphql -f query='
    query($o:String!,$r:String!,$n:Int!){
      repository(owner:$o,name:$r){
        issue(number:$n){
          number title issueType{name}
          subIssuesSummary{total completed}
          subIssues(first:50){nodes{
            number title state issueType{name}
            subIssuesSummary{total completed}
            subIssues(first:100){nodes{number title state issueType{name}}}
          }}
        }
      }
    }' -f o="$owner" -f r="$repo" -F n="$1" \
    | jq -r --arg color "$color" '
      ($color == "1") as $C
      | "[" as $e
      | def rst: if $C then $e + "0m" else "" end;
        def col(code; s): if $C then $e + code + "m" + s + rst else s end;
        def dim(s):  col("2"; s);
        def bold(s): col("1"; s);
        def chip(t):
          if   t == "Initiative" then col("36;1"; "[" + t + "]")
          elif t == "Epic"       then col("35";   "[" + t + "]")
          elif t == "Story"      then col("32";   "[" + t + "]")
          elif t == "Spike"      then col("33";   "[" + t + "]")
          elif t == "Bug"        then col("31";   "[" + t + "]")
          else "[" + (t // "?") + "]" end;
        def prog(done; total):
          ("(" + (done|tostring) + "/" + (total|tostring) + ")") as $p
          | if   total > 0 and done == total then col("32"; $p)
            elif total > 0                    then col("33"; $p)
            else dim($p) end;
        def title(s; st): if st == "CLOSED" then dim(s) else s end;
        def mark(st): if st == "CLOSED" then col("32"; "✓") else col("90"; "○") end;

        .data.repository.issue as $i
        | ($i.subIssues.nodes | length) as $ne
        | bold("▸ #" + ($i.number|tostring)) + " " + chip($i.issueType.name)
            + " " + bold($i.title) + "  "
            + prog($i.subIssuesSummary.completed; $i.subIssuesSummary.total) + dim(" epics"),
          ( $i.subIssues.nodes | to_entries[]
            | .key as $k | .value as $ep
            | ($k == $ne - 1) as $lastE
            | (if $lastE then "└─ " else "├─ " end) as $ec
            | (if $lastE then "   " else "│  " end) as $eg
            | ($ep.subIssues.nodes | length) as $ns
            | dim($ec) + "#" + ($ep.number|tostring) + " " + chip($ep.issueType.name)
                + " " + title($ep.title; $ep.state) + "  "
                + prog($ep.subIssuesSummary.completed; $ep.subIssuesSummary.total),
              ( $ep.subIssues.nodes | to_entries[]
                | .key as $j | .value as $st
                | ($j == $ns - 1) as $lastS
                | (if $lastS then "└─ " else "├─ " end) as $sc
                | dim($eg + $sc) + mark($st.state) + " #" + ($st.number|tostring)
                    + " " + chip($st.issueType.name) + " " + title($st.title; $st.state) )
          )
    '
}

pick() { # fzf picker; optional $1 pre-seeds the query. Echoes chosen number (empty if cancelled).
  local query="${1:-}" rows sel
  rows="$(list_initiatives)"
  [ -n "$rows" ] || { echo "No open Initiatives in $owner/$repo." >&2; return 1; }
  if command -v fzf >/dev/null 2>&1; then
    sel="$(printf '%s\n' "$rows" | fzf --delimiter=$'\t' --with-nth=2.. \
            --prompt='Initiative > ' --height=90% --reverse --query="$query" \
            --header='pick an Initiative (↑↓ to preview · enter to open · esc to cancel)' \
            --preview="INITIATIVE_COLOR=1 $self {1}" \
            --preview-window='down,72%,nowrap,border-top' \
            --preview-label=' tree ')" || return 1
    printf '%s' "$sel" | cut -f1
  else
    printf '%s\n' "$rows" | sed 's/^/  #/' >&2
    echo "fzf not installed — re-run: gh initiative <number>" >&2
    return 1
  fi
}

cmd="${1:-}"
cmd="${cmd#\#}"   # tolerate a leading '#'
case "$cmd" in
  --all | -a)
    nums="$(list_initiatives | cut -f1)"
    [ -n "$nums" ] || { echo "No open Initiatives in $owner/$repo." >&2; exit 0; }
    first=1
    for n in $nums; do [ "$first" -eq 1 ] || echo; first=0; print_tree "$n"; done
    ;;
  --list | -l)
    list_initiatives | sed 's/^/#/'
    ;;
  '')
    num="$(pick || true)"
    [ -n "$num" ] && print_tree "$num"
    ;;
  *[!0-9]*)
    num="$(pick "$*" || true)"
    [ -n "$num" ] && print_tree "$num"
    ;;
  *)
    print_tree "$cmd"
    ;;
esac
