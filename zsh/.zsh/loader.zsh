# =============================================================================
# Zsh Modular Configuration Loader
# =============================================================================
# This file sources all modular configuration files
# Add this to your .zshrc: source ~/.zsh/loader.zsh

# Load all alias files
if [[ -d ~/.zsh/aliases ]]; then
  for alias_file in ~/.zsh/aliases/*.zsh; do
    [[ -f "$alias_file" ]] && source "$alias_file"
  done
fi

# Load all function files (if you create them later)
if [[ -d ~/.zsh/functions ]]; then
  for func_file in ~/.zsh/functions/*.zsh; do
    [[ -f "$func_file" ]] && source "$func_file"
  done
fi

# Load all environment files (if you create them later)
if [[ -d ~/.zsh/env ]]; then
  for env_file in ~/.zsh/env/*.zsh; do
    [[ -f "$env_file" ]] && source "$env_file"
  done
fi
