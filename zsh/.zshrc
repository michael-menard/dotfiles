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

# `wt <story-number>` shortcut: cd into the monorepo primary checkout, create the
# feat/<n>-auto worktree, and launch Claude Code in auto-accept-edits mode. Any other
# `wt ...` invocation passes straight through to worktrunk's real function untouched.
if typeset -f wt >/dev/null; then
  functions[_wt_orig]=$functions[wt]
  wt() {
    if [[ ( $# -eq 1 || $# -eq 2 ) && "$1" == <-> ]]; then
      builtin cd ~/Development/Monorepo || return
      local branch="feat/$1-auto"
      local prompt="${2:-implement $1}"
      # If a worktree for the branch already exists, cd straight into it and
      # launch Claude there; otherwise let worktrunk create it (`switch --create`).
      local wt_path
      wt_path=$(git -C ~/Development/Monorepo worktree list --porcelain 2>/dev/null \
        | awk -v b="refs/heads/$branch" '/^worktree /{p=$2} $0=="branch "b{print p; exit}')
      if [[ -n "$wt_path" ]]; then
        echo "wt: worktree for $branch already exists — launching Claude in $wt_path" >&2
        builtin cd "$wt_path" || return
        claude --permission-mode acceptEdits "$prompt"
      else
        _wt_orig switch --create "$branch" -x claude -- \
          --permission-mode acceptEdits "$prompt"
      fi
    else
      _wt_orig "$@"
    fi
  }

  # `impl <story-number> [prompt]` — dedicated alias for the `wt <n>` story flow:
  # create the feat/<n>-auto worktree and launch Claude in auto-accept-edits mode.
  impl() {
    if [[ ( $# -eq 1 || $# -eq 2 ) && "$1" == <-> ]]; then
      wt "$@"
    else
      echo "usage: impl <story-number> [prompt]" >&2
      return 2
    fi
  }
fi

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
