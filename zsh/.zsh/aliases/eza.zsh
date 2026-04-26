# =============================================================================
# Eza (modern ls replacement) Configuration
# =============================================================================

# Verify eza is installed
if command -v eza &> /dev/null; then

  # Default eza options
  # --icons: show file/folder icons
  # --group-directories-first: list directories before files
  # --git: show git status
  # --color=auto: colorize output
  export EZA_COLORS="da=36:gm=33"

  # Basic ls replacement
  alias ls='eza --icons --group-directories-first'
  alias ll='eza --icons --group-directories-first -l --git'
  alias la='eza --icons --group-directories-first -la --git'
  alias l='eza --icons --group-directories-first -lah --git'

  # Tree views
  alias lt='eza --icons --group-directories-first --tree --level=2'
  alias lt3='eza --icons --group-directories-first --tree --level=3'
  alias lta='eza --icons --group-directories-first --tree --level=2 -a'

  # Detailed views
  alias ld='eza --icons --group-directories-first -lD'  # Only directories
  alias lf='eza --icons --group-directories-first -lf'  # Only files
  alias lh='eza --icons --group-directories-first -dl .*'  # Only hidden files

  # Sort by different criteria
  alias lS='eza --icons --group-directories-first -l --sort=size'  # Sort by size
  alias lm='eza --icons --group-directories-first -l --sort=modified'  # Sort by modified time
  alias lc='eza --icons --group-directories-first -l --sort=created'  # Sort by created time

  # Git-focused
  alias lg='eza --icons --group-directories-first -l --git --git-ignore'  # Respect .gitignore
  alias lgi='eza --icons --group-directories-first -l --git'  # Show git status

  # Long format with extended attributes and headers
  alias lla='eza --icons --group-directories-first -lah --git --extended --header'

fi
