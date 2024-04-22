#!/bin/bash

# Define log file path 
LOG_FILE="$1"

# Function to log messages and exit on error
log_and_exit() {
  echo "ERROR: $1" >&2
  exit 1
}

# Check if log file exists
if [[ ! -f "$LOG_FILE" ]]; then
  log_and_exit "Log file '$LOG_FILE' does not exist."
fi

# Function to handle termination signal (Ctrl+C)
trap "echo; exit 0" SIGINT

# Initialize counters and empty variable for top error message
error_count=0
warning_count=0
top_error_message=""

# Monitor log file continuously
echo "Monitoring log file: $LOG_FILE (Press Ctrl+C to stop)"
tail -f "$LOG_FILE" | while read -r line; do

  # Analyze log entries
  if grep -q "ERROR" <<< "$line"; then
    ((error_count++))
    # Capture the first error message for reporting (modify if needed)
    if [[ -z "$top_error_message" ]]; then
      top_error_message="$line"
    fi
  elif grep -q "WARNING" <<< "$line"; then
    ((warning_count++))
  fi

done

# Display summary report

echo "Log Monitoring Summary:"
echo "  - Errors: $error_count"
echo "  - Warnings: $warning_count"

# Printing top error messages
if [[ -n "$top_error_message" ]]; then
  echo "  - Top Error Message:"
  echo "    - $top_error_message"
fi

echo "Monitoring stopped."

exit 0
