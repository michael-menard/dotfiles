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
