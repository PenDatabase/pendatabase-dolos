#!/usr/bin/env bash
# Wrapper to start Dolos in Heroku environment
# Ensures PORT is set, prints env, forwards signals and logs child exit code cleanly.

set -euo pipefail

# Default PORT if not provided by Heroku (useful for local testing)
PORT="${PORT:-3000}"
export PORT

echo "Starting Dolos wrapper - $(date) - PORT=${PORT}"
echo "Node options: ${NODE_OPTIONS:-<none>}"

# Function to forward SIGTERM/SIGINT to child
_term() {
  echo "Wrapper received SIGTERM/SIGINT - forwarding to child (pid=$child_pid)"
  kill -TERM "${child_pid}" 2>/dev/null || true
  wait "${child_pid}"
  exit_code=$?
  echo "Child exited after forwarded signal with exit code ${exit_code}"
  exit "${exit_code}"
}

trap _term SIGTERM SIGINT

# Start the real process and capture its PID
# Adjust the start command if you built Dolos differently (npm start / node dist/..)
# Use 'exec' if you want the child to replace the shell, but here we capture its pid.
npm start &
child_pid=$!

# Wait for child to exit and capture exit status safely
wait "${child_pid}" || true
exit_code=$?

# Print result and exit with same code
echo "Dolos process (pid=${child_pid}) exited with code ${exit_code} at $(date)"
exit "${exit_code}"