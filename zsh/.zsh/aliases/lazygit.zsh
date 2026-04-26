# =============================================================================
# Lazygit (Terminal UI for git) Configuration
# =============================================================================

# Verify lazygit is installed
if command -v lazygit &> /dev/null; then

  # Basic aliases
  alias lg='lazygit'
  alias lzg='lazygit'

  # Start in specific panels
  alias lgs='lazygit status'      # Start in status panel
  alias lgb='lazygit branch'      # Start in branch panel
  alias lgl='lazygit log'         # Start in log panel
  alias lgst='lazygit stash'      # Start in stash panel

  # Lazygit with specific options
  alias lg-debug='lazygit --debug'          # Run in debug mode
  alias lg-logs='lazygit --logs'            # Tail lazygit logs
  alias lg-config='lazygit --config'        # Print default config
  alias lg-configdir='lazygit --print-config-dir'  # Print config directory

  # Lazygit in different screen modes
  alias lg-half='lazygit --screen-mode half'    # Half screen mode
  alias lg-full='lazygit --screen-mode full'    # Full screen mode

  # Lazygit for specific path
  function lg-path {
    if [[ -z "$1" ]]; then
      echo "Usage: lg-path <path>"
      return 1
    fi
    lazygit --path "$1"
  }

  # Lazygit with filter on specific file/path
  function lg-filter {
    if [[ -z "$1" ]]; then
      echo "Usage: lg-filter <file-or-path>"
      echo "Shows commits/history for specific file or path"
      return 1
    fi
    lazygit --filter "$1"
  }

  # Lazygit for dotfiles (if you have a bare repo setup)
  alias lg-dotfiles='lazygit --work-tree=$HOME --git-dir=$HOME/.dotfiles/.git'

  # Lazygit for common project directories (customize these)
  alias lg-home='lazygit --path ~'
  alias lg-dot='lazygit --path ~/dotfiles'

fi
