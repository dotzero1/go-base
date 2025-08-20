#!/bin/bash

SHARED_DIR="/shared"
CMD_PATH="$SHARED_DIR/cmd"
CONFIG_PATH="$SHARED_DIR/config.json"
PID_PATH="$SHARED_DIR/wrapper.pid"
CHILD_PID=""

# Poll for initial binary and config
while [ ! -f "$CMD_PATH" ] || [ ! -f "$CONFIG_PATH" ]; do
  sleep 1
done

# Write wrapper PID
echo $$ > "$PID_PATH"

# Signal handler
trap 'handle_swap' USR1

handle_swap() {
  if [ ! -z "$CHILD_PID" ]; then
    kill -TERM "$CHILD_PID"  # Graceful shutdown
    wait "$CHILD_PID"
  fi
  run_child
}

run_child() {
  "$CMD_PATH" --config "$CONFIG_PATH" &  # Run binary as child with config
  CHILD_PID=$!
  wait "$CHILD_PID"  # Wait for exit to restart if needed
  exit $?  # Propagate exit code
}

run_child
