# Shebang :
#!/bin/bash specifies the interpreter to be used (bash shell).
# Log File Path :
LOG_FILE="$1" defines a variable to store the log file path provided as the first argument.
# Error Handling Function :
log_and_exit() { ... } defines a function that logs an error message and exits the script with an error code.
# Log File Check:
Checks if the specified log file exists. If not, it calls log_and_exit to report the error and terminate.
# Signal Handling:
trap "echo; exit 0" SIGINT defines a trap to handle the SIGINT signal (Ctrl+C). When triggered, it prints a message and exits the script gracefully.
# Analysis Counters:
Initializes variables error_count, warning_count, and top_error_message for storing analysis results.
# Monitoring Loop:
tail -f "$LOG_FILE" | while read -r line; do ... done continuously monitors the log file using tail -f. Each new line is read within the while loop.
# Analyzes the log line:
If it contains "ERROR" (using grep -q), increments error_count and optionally captures the first error message.
Similar logic for warnings with "WARNING".
# Summary Report 
Prints a summary report after exiting the loop, including error/warning counts.
If a top error message was captured, it's displayed.
# Monitoring Stopped Message (Line 50):
Informs the user that monitoring has stopped.
# Exit:
Script exits with a successful exit code (0).

**Here is how to use this :**
1. Save the script as a file (e.g., log_monitor.sh).
2. Make the script executable: chmod +x log_monitor.sh.
3. Run the script, specifying the log file path as an argument: ./log_monitor.sh /var/log/your_logfile.log
