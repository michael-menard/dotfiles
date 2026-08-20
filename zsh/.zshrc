# =============================================================================
# Oh My Zsh
# =============================================================================
export ZSH="$HOME/.oh-my-zsh"

plugins=(git aws)

source $ZSH/oh-my-zsh.sh

# =============================================================================
# Shell Plugins (installed via brew)
# =============================================================================
# zsh-completions (must be before compinit)
if [[ -d /opt/homebrew/share/zsh-completions ]]; then
  FPATH="/opt/homebrew/share/zsh-completions:$FPATH"
  autoload -Uz compinit && compinit
fi

# Autosuggestions
[[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && \
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Syntax highlighting (must be last)
[[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && \
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Fast syntax highlighting (alternative — only one should be active)
# [[ -f /opt/homebrew/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ]] && \
#   source /opt/homebrew/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# =============================================================================
# Runtime Version Managers
# =============================================================================
# asdf (personal machine)
if [[ -f /opt/homebrew/opt/asdf/libexec/asdf.sh ]]; then
  source /opt/homebrew/opt/asdf/libexec/asdf.sh
fi

# mise (work machine — replaces asdf)
if command -v mise &>/dev/null; then
  eval "$(mise activate zsh)"
fi

# =============================================================================
# PATH
# =============================================================================
export PATH="/opt/homebrew/opt/bzip2/bin:$PATH"
export PATH="/opt/homebrew/opt/sqlite/bin:$PATH"
export PATH="$PATH:$HOME/.local/bin"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# =============================================================================
# Prompt
# =============================================================================
eval "$(starship init zsh)"

# =============================================================================
# Navigation
# =============================================================================
eval "$(zoxide init zsh)"

# =============================================================================
# Docker Completions (Docker Desktop — personal machine only)
# =============================================================================
if [[ -d "$HOME/.docker/completions" ]]; then
  fpath=("$HOME/.docker/completions" $fpath)
  autoload -Uz compinit && compinit
fi

# =============================================================================
# Worktrunk
# =============================================================================
if command -v wt &>/dev/null; then
  eval "$(command wt config shell init zsh)"
fi

# `story <n>` and `epic <n>` — drive the `orchestrate-issue` Pi workflow for a
# single story or a whole epic. Both cd into the monorepo primary checkout, stash
# any dirty main aside (main stays pristine), and launch an interactive Pi session
# whose first message is the `/orchestrate-issue issueNumber=<n>` slash command. The
# workflow runs in the background inside the session and posts its report when it
# finishes — it IS the single implementation pipeline (groom → dev-loop-story →
# in-loop pr-shepherd → post-merge), so these are thin entrypoints, not a parallel
# implementation path. Model: no pin — both ride Pi's default (ollama-cloud glm-5.2),
# keeping dev-loop-story's medium→big tier escalation intact; override per-run via
# the global default (settings.json), not a flag here. `wt` is left as worktrunk's
# real command — the story-number interception that used to live there moved here.

story() {
  if [[ $# -ne 1 || "$1" != <-> ]]; then
    echo "usage: story <story-number>" >&2
    return 2
  fi
  printf '\033]2;story %s\007' "$1"
  builtin cd ~/Development/Monorepo || return
  # Keep main pristine: stash stray tracked changes on main aside.
  if [[ "$(git symbolic-ref --quiet --short HEAD 2>/dev/null)" == "main" ]] \
     && ! git diff --quiet HEAD 2>/dev/null; then
    git stash push --quiet -m "story-autostash-$1" \
      && echo "story: primary main was dirty — stashed to 'story-autostash-$1' (restore: git stash pop)" >&2
  fi
  # Resolve-or-create the story worktree via the single writer. epic-start prepare
  # now owns create + best-effort freshen to origin/main (no inline awk/ff-only here).
  local wt_path
  wt_path=$(node .github/scripts/epic-start.cjs prepare "$1" --json 2>/dev/null \
    | jq -r .worktreePath)
  if [[ -n "$wt_path" && "$wt_path" != "null" ]]; then
    builtin cd "$wt_path" || return
    echo "story: worktree for #$1 → $wt_path" >&2
  else
    echo "story: ⚠ could not resolve a worktree for #$1 — epic-start prepare failed (see above). Aborting; main left pristine." >&2
    return 1
  fi
  pi "/orchestrate-issue issueNumber=$1"
}

epic() {
  if [[ $# -ne 1 || "$1" != <-> ]]; then
    echo "usage: epic <epic-number>" >&2
    return 2
  fi
  printf '\033]2;epic %s\007' "$1"
  builtin cd ~/Development/Monorepo || return
  # Keep main pristine: stash stray tracked changes on main aside.
  if [[ "$(git symbolic-ref --quiet --short HEAD 2>/dev/null)" == "main" ]] \
     && ! git diff --quiet HEAD 2>/dev/null; then
    git stash push --quiet -m "epic-autostash-$1" \
      && echo "epic: primary main was dirty — stashed to 'epic-autostash-$1' (restore: git stash pop)" >&2
  fi
  # Symmetric adoption: launch from an isolated worktree, never the primary.
  # Prefer the first Ready story's worktree; else create an epic launch-surface
  # worktree (chore/<epic>-orchestrator) that orchestrate-issue removes in its
  # Report phase. Fail-closed if neither resolves — no --force escape hatch.
  local first_ready wt_path
  first_ready=$(gh api repos/CodeFika/monorepo/issues/$1/sub_issues \
    --paginate \
    --jq '.[] | select(.state=="open") | .number' 2>/dev/null \
    | while read -r n; do
        node .github/scripts/board.cjs status "$n" --json 2>/dev/null \
          | jq -r --arg n "$n" 'select(.data[].status=="ready") | $n' 2>/dev/null
      done | head -1)
  if [[ -n "$first_ready" ]]; then
    wt_path=$(node .github/scripts/epic-start.cjs prepare "$first_ready" --json \
      2>/dev/null | jq -r .worktreePath)
    echo "epic: first Ready story #$first_ready — adopting its worktree" >&2
  else
    wt_path=$(node .github/scripts/epic-start.cjs start --epic "$1" --json \
      2>/dev/null | jq -r .worktreePath)
    echo "epic: no Ready stories yet — created epic launch-surface worktree (chore/$1-orchestrator)" >&2
  fi
  if [[ -n "$wt_path" && "$wt_path" != "null" ]]; then
    builtin cd "$wt_path" || return
    echo "epic: worktree for #$1 → $wt_path" >&2
  else
    echo "epic: ⚠ could not resolve any worktree for #$1 (epic-start failed)." >&2
    echo "      Aborting; main left pristine. To override, run:" >&2
    echo "        pi \"/orchestrate-issue issueNumber=$1\"" >&2
    return 1
  fi
  pi "/orchestrate-issue issueNumber=$1"
}

# Nag whenever the PRIMARY Monorepo checkout is on `main` with a dirty tree — main
# is the shared HEAD every root pane sees and should stay pristine, so catch stray
# uncommitted edits before they compound. Cheap: bail unless PWD is inside the
# primary path, then one `git rev-parse` to exclude the linked worktrees that live
# under it (they're never on `main`). `story`/`epic` auto-stashes these when it starts
# a story; this is the continuous reminder in between.
_monorepo_main_dirty_warn() {
  [[ "$PWD" == ~/Development/Monorepo || "$PWD" == ~/Development/Monorepo/* ]] || return
  [[ "$(git rev-parse --show-toplevel 2>/dev/null)" == ~/Development/Monorepo ]] || return
  [[ "$(git symbolic-ref --quiet --short HEAD 2>/dev/null)" == "main" ]] || return
  git diff --quiet HEAD 2>/dev/null && return
  local n
  n=$(git diff --name-only HEAD 2>/dev/null | grep -c .)
  echo "⚠ main is DIRTY in the primary checkout ($n tracked file(s)) — stash or restore:" >&2
  git status --short --untracked-files=no 2>/dev/null | sed 's/^/   /' >&2
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd _monorepo_main_dirty_warn

# =============================================================================
# Claude Code (personal machine only)
# =============================================================================
if command -v claude &>/dev/null; then
  export USE_BUILTIN_RIPGREP=0

  alias cc='claude'
  alias ccd='claude .'

  cco() {
    claude "${@}"
  }

  ccm() {
    local modified=$(git diff --name-only 2>/dev/null)
    [[ -n "$modified" ]] && claude $modified || echo "No modified files found"
  }

  ccs() {
    local staged=$(git diff --cached --name-only 2>/dev/null)
    [[ -n "$staged" ]] && claude $staged || echo "No staged files found"
  }

  ccp() {
    [[ -z "$1" ]] && { echo "Usage: ccp <pattern>"; return 1; }
    local files=$(find . -name "$1" -type f)
    [[ -n "$files" ]] && claude $files || echo "No files matching '$1' found"
  }
fi

# =============================================================================
# OpenCode (personal machine only)
# =============================================================================
if command -v opencode &>/dev/null; then
  alias oc='opencode'
  alias oc-sonnet='opencode --model anthropic/claude-sonnet-4'
  alias oc-haiku='opencode --model anthropic/claude-haiku-3.5'
  alias oc-4o='opencode --model openai/gpt-4o'
  alias oc-4o-mini='opencode --model openai/gpt-4o-mini'
  alias oc-gemini='opencode --model openrouter/gemini-flash'
  alias oc-deepseek='opencode --model ollama/deepseek-coder-v2:16b'
fi

# =============================================================================
# Task Master (personal machine only)
# =============================================================================
if command -v task-master &>/dev/null; then
  alias tm='task-master'
  alias taskmaster='task-master'
fi

# =============================================================================
# Modular Aliases and Functions
# =============================================================================
[[ -f ~/.zsh/loader.zsh ]] && source ~/.zsh/loader.zsh

# =============================================================================
# Environment Variables (secrets — not in git)
# =============================================================================
[[ -f ~/.env ]] && export $(grep -v '^#' ~/.env | xargs)

# =============================================================================
# Machine-Specific Overrides
# =============================================================================
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/michaelmenard/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

# herdr: kill the tab (klt) / space (kls) you're currently focused in
klt() {
  local tab
  tab=$(herdr workspace list | python3 -c 'import sys,json
w=next((x for x in json.load(sys.stdin)["result"]["workspaces"] if x["focused"]), None)
print(w["active_tab_id"]) if w else exit(1)') || { echo "klt: no focused workspace"; return 1; }
  herdr tab close "$tab"
}

kls() {
  local ws
  ws=$(herdr workspace list | python3 -c 'import sys,json
w=next((x for x in json.load(sys.stdin)["result"]["workspaces"] if x["focused"]), None)
print(w["workspace_id"]) if w else exit(1)') || { echo "kls: no focused workspace"; return 1; }
  herdr workspace close "$ws"
}

# herdr: kill the agent (kla) = close the currently focused pane
kla() {
  local pane
  pane=$(herdr pane list | python3 -c 'import sys,json
p=next((x for x in json.load(sys.stdin)["result"]["panes"] if x["focused"]), None)
print(p["pane_id"]) if p else exit(1)') || { echo "kla: no focused pane"; return 1; }
  herdr pane close "$pane"
}

# ── zellij ───────────────────────────────────────────────
# Attach to session "main" if it exists, otherwise create it.
alias zj='zellij attach -c main'
# Launch the dev layout in a fresh session:
alias zjdev='zellij --layout dev'
# Claude 3-column workspace (converted from tmuxinator):
alias zjclaude='zellij --layout claude'

# Pi
export PATH="/Users/michaelmenard/.local/share/mise/installs/node/22.23.1/bin:$PATH"

# wrkr: run the autonomous LangGraph dev-loop supervisor in work-pane sessions
export WRKR_AGENT=devloop
