# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
# ZSH_THEME="lambda"
# ZSH_THEME="jbergantine"


# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	asdf 
	git 
	aws
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias npm-list-global='npm list -g --depth=0'



# Task Master aliases added on 6/21/2025
alias tm='task-master'
alias taskmaster='task-master'
export PATH="/opt/homebrew/opt/bzip2/bin:$PATH"
export PATH="/opt/homebrew/opt/sqlite/bin:$PATH"
export PATH="/opt/homebrew/opt/bzip2/bin:$PATH"

# Created by `pipx` on 2025-09-28 01:22:59
export PATH="$PATH:/Users/michaelmenard/.local/bin"

# Use system ripgrep instead of Claude Code built-in
export USE_BUILTIN_RIPGREP=0

unset ANTHROPIC_API_KEY

# Starship prompt
eval "$(starship init zsh)"
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/michaelmenard/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

# =============================================================================
# Claude Code Aliases and Functions
# =============================================================================

# Quick alias for Claude Code
alias cc='claude code'

# Open entire current directory in Claude Code
alias ccd='claude code .'

# Open multiple files easily
cco() {
  local files=()
  for arg in "$@"; do
    files+=("$arg")
  done
  claude code "${files[@]}"
}

# Open all modified git files in Claude Code
ccm() {
  local modified=$(git diff --name-only 2>/dev/null)
  if [[ -n "$modified" ]]; then
    claude code $modified
  else
    echo "No modified files found"
  fi
}

# Open all staged git files in Claude Code
ccs() {
  local staged=$(git diff --cached --name-only 2>/dev/null)
  if [[ -n "$staged" ]]; then
    claude code $staged
  else
    echo "No staged files found"
  fi
}

# Open files matching a pattern in Claude Code
ccp() {
  if [[ -z "$1" ]]; then
    echo "Usage: ccp <pattern>"
    echo "Example: ccp '*.ts'"
    return 1
  fi
  local files=$(find . -name "$1" -type f)
  if [[ -n "$files" ]]; then
    claude code $files
  else
    echo "No files matching pattern '$1' found"
  fi
}

# Open files in a specific directory
ccdir() {
  if [[ -z "$1" ]]; then
    echo "Usage: ccdir <directory>"
    return 1
  fi
  claude code "$1"
}

# Quick open recent project directories (customize these paths)
alias cc-proj='claude code ~/Development/tutorials/langchain/lang-chain-ts-course'
alias cc-4='claude code ~/Development/tutorials/langchain/lang-chain-ts-course/apps/proj-4-intro-langchain'

# End of Claude Code configuration

. /opt/homebrew/opt/asdf/libexec/asdf.sh

# pnpm
export PNPM_HOME="/Users/michaelmenard/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# bun completions
[ -s "/Users/michaelmenard/.bun/_bun" ] && source "/Users/michaelmenard/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
eval "$(direnv hook zsh)"

# OpenCode model aliases
alias oc='opencode'                                                    # Shortcut for opencode

# OpenAI models (requires OPENAI_API_KEY in ~/.env)
alias oc-4o='opencode --model openai/gpt-4o'                         # GPT-4o (best reasoning)
alias oc-4o-mini='opencode --model openai/gpt-4o-mini'               # GPT-4o mini (fast, cheap)
alias oc-o1='opencode --model openai/o1'                             # o1 (advanced reasoning)
alias oc-o1-mini='opencode --model openai/o1-mini'                   # o1 mini (fast reasoning)

# Anthropic models (requires ANTHROPIC_API_KEY in ~/.env)
alias oc-sonnet='opencode --model anthropic/claude-sonnet-4'         # Claude Sonnet 4 (latest)
alias oc-sonnet35='opencode --model anthropic/claude-sonnet-3.5'     # Claude Sonnet 3.5
alias oc-haiku='opencode --model anthropic/claude-haiku-3.5'         # Claude Haiku 3.5 (fast)

# OpenCode hosted models (free)
alias oc-nano='opencode --model opencode/gpt-5-nano'                  # Fast free cloud model
alias oc-pickle='opencode --model opencode/big-pickle'                # OpenCode's own model
alias oc-minimax='opencode --model opencode/minimax-m2.5-free'        # MiniMax free model
alias oc-trinity='opencode --model opencode/trinity-large-preview-free' # Trinity large model

# Local Ollama models (requires Ollama running on localhost:11434)
alias oc-qwen='opencode --model ollama/qwen-local'                    # Local Qwen 7B (fast)
alias oc-qwen14='opencode --model ollama/qwen-14b'                    # Local Qwen 14B (better)
alias oc-deepseek='opencode --model ollama/deepseek-coder-v2:16b'    # Local DeepSeek 16B
alias oc-codellama='opencode --model ollama/codellama:13b'            # Local CodeLlama 13B

# =============================================================================
# Modular Zsh Configuration (managed by stow)
# =============================================================================
[[ -f ~/.zsh/loader.zsh ]] && source ~/.zsh/loader.zsh

# =============================================================================
# Load Environment Variables (not in git)
# =============================================================================
# Load environment variables from .env (contains API keys and secrets)
if [[ -f ~/.env ]]; then
  export $(cat ~/.env | grep -v '^#' | xargs)
fi

