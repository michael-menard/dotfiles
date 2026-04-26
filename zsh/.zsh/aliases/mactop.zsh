# =============================================================================
# Mactop (macOS system monitor) Configuration
# =============================================================================

# Verify mactop is installed
if command -v mactop &> /dev/null; then

  # Basic aliases
  alias mt='mactop'
  alias mactop-fast='mactop --interval 500'        # Update every 500ms
  alias mactop-slow='mactop --interval 2000'       # Update every 2s

  # Themed variants
  alias mt-purple='mactop --foreground "#9580FF" --bg "#22212C"'
  alias mt-green='mactop --foreground green --bg black'
  alias mt-blue='mactop --foreground "#61AFEF" --bg "#282C34"'
  alias mt-cyber='mactop --foreground "#00FF00" --bg "#000000"'

  # Temperature units
  alias mt-f='mactop --unit-temp fahrenheit'
  alias mt-c='mactop --unit-temp celsius'

  # Headless/monitoring mode (JSON output)
  alias mt-json='mactop --headless --format json --pretty'
  alias mt-monitor='mactop --headless --format json --pretty --count 10'

  # Prometheus metrics server
  alias mt-prometheus='mactop --prometheus :9090'

  # Menu bar mode
  alias mt-menubar='mactop --menubar'

  # Quick sampling (take 5 samples and exit)
  alias mt-sample='mactop --headless --format json --pretty --count 5'

fi
