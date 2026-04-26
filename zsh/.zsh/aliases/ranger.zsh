# =============================================================================
# Ranger (terminal file manager) Configuration
# =============================================================================

# Verify ranger is installed
if command -v ranger &> /dev/null; then

  # Basic aliases
  alias r='ranger'
  alias ra='ranger'

  # Ranger with specific starting directory
  alias rh='ranger ~'                    # Start in home directory
  alias rd='ranger ~/Downloads'          # Start in Downloads
  alias rp='ranger ~/Projects'           # Start in Projects (customize as needed)
  alias rdt='ranger ~/dotfiles'          # Start in dotfiles

  # Ranger with specific options
  alias ranger-clean='ranger --clean'    # Don't use any config files
  alias ranger-select='ranger --selectfile'  # Open with specific file selected

  # Ranger-cd: Change to the directory you exit from in ranger
  # This is one of the most useful ranger features!
  function ranger-cd {
    local tempfile="$(mktemp -t tmp.XXXXXX)"
    ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    if [ -f "$tempfile" ]; then
      local rangedir="$(cat "$tempfile")"
      if [ "$rangedir" != "$(pwd)" ]; then
        cd -- "$rangedir"
      fi
      rm -f "$tempfile"
    fi
  }

  # Alias for ranger-cd
  alias rcd='ranger-cd'
  alias rc='ranger-cd'

  # Ranger file chooser: Select a file and return its path
  function ranger-choose {
    local tempfile="$(mktemp -t tmp.XXXXXX)"
    ranger --choosefile="$tempfile" "${@:-$(pwd)}"
    if [ -f "$tempfile" ]; then
      local chosen_file="$(cat "$tempfile")"
      if [ -n "$chosen_file" ]; then
        echo "$chosen_file"
      fi
      rm -f "$tempfile"
    fi
  }

  # Alias for ranger-choose
  alias rchoose='ranger-choose'

  # Open ranger and edit the selected file
  function ranger-edit {
    local file="$(ranger-choose "$@")"
    if [ -n "$file" ]; then
      ${EDITOR:-vim} "$file"
    fi
  }

  # Alias for ranger-edit
  alias re='ranger-edit'

fi
