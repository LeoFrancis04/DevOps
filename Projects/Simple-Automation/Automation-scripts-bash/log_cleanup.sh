#!/bin/bash

################################################################################
# Script Name: log_cleanup.sh
# Description: Automates cleaning up old log files to free up disk space
# Author: DevOps Learning Project
# Usage: ./log_cleanup.sh [options]
################################################################################

# Exit on any error
set -e

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Default values
LOG_DIR="/var/log"
DAYS_OLD=30
DRY_RUN=false

# Function to display usage information
usage() {
    echo "Usage: $0 [-d directory] [-t days] [-n]"
    echo "  -d: Directory to clean (default: /var/log)"
    echo "  -t: Delete files older than X days (default: 30)"
    echo "  -n: Dry run - show what would be deleted without deleting"
    echo "  -h: Display this help message"
    exit 1
}

# Function to print colored messages
print_message() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

# Parse command line arguments
while getopts "d:t:nh" opt; do
    case $opt in
        d) LOG_DIR="$OPTARG" ;;
        t) DAYS_OLD="$OPTARG" ;;
        n) DRY_RUN=true ;;
        h) usage ;;
        *) usage ;;
    esac
done

# Validate inputs
if [ ! -d "$LOG_DIR" ]; then
    print_message "$RED" "Error: Directory $LOG_DIR does not exist!"
    exit 1
fi

if ! [[ "$DAYS_OLD" =~ ^[0-9]+$ ]]; then
    print_message "$RED" "Error: Days must be a number!"
    exit 1
fi

# Main execution
print_message "$GREEN" "=========================================="
print_message "$GREEN" "Log Cleanup Script Started"
print_message "$GREEN" "=========================================="
echo "Directory: $LOG_DIR"
echo "Deleting files older than: $DAYS_OLD days"
echo "Dry run: $DRY_RUN"
echo ""

# Get disk usage before cleanup
DISK_BEFORE=$(df -h "$LOG_DIR" | awk 'NR==2 {print $3}')
print_message "$YELLOW" "Disk usage before cleanup: $DISK_BEFORE"

# Find and process old log files
if [ "$DRY_RUN" = true ]; then
    print_message "$YELLOW" "\n[DRY RUN MODE] Files that would be deleted:"
    find "$LOG_DIR" -type f -name "*.log" -mtime +$DAYS_OLD -print
    find "$LOG_DIR" -type f -name "*.log.*" -mtime +$DAYS_OLD -print
    
    # Count files
    FILE_COUNT=$(find "$LOG_DIR" -type f \( -name "*.log" -o -name "*.log.*" \) -mtime +$DAYS_OLD | wc -l)
    print_message "$YELLOW" "\nTotal files to be deleted: $FILE_COUNT"
else
    print_message "$GREEN" "\nDeleting old log files..."
    
    # Delete .log files older than specified days
    DELETED_COUNT=0
    while IFS= read -r file; do
        if [ -f "$file" ]; then
            rm -f "$file"
            echo "Deleted: $file"
            ((DELETED_COUNT++))
        fi
    done < <(find "$LOG_DIR" -type f \( -name "*.log" -o -name "*.log.*" \) -mtime +$DAYS_OLD)
    
    print_message "$GREEN" "\nSuccessfully deleted $DELETED_COUNT files"
    
    # Get disk usage after cleanup
    DISK_AFTER=$(df -h "$LOG_DIR" | awk 'NR==2 {print $3}')
    print_message "$YELLOW" "Disk usage after cleanup: $DISK_AFTER"
fi

# Compress recent log files (older than 7 days but newer than threshold)
COMPRESS_THRESHOLD=7
print_message "$YELLOW" "\nCompressing log files older than $COMPRESS_THRESHOLD days..."

COMPRESSED_COUNT=0
while IFS= read -r file; do
    if [ -f "$file" ] && [[ ! "$file" == *.gz ]]; then
        if [ "$DRY_RUN" = true ]; then
            echo "Would compress: $file"
        else
            gzip "$file"
            echo "Compressed: $file"
        fi
        ((COMPRESSED_COUNT++))
    fi
done < <(find "$LOG_DIR" -type f -name "*.log" -mtime +$COMPRESS_THRESHOLD -mtime -$DAYS_OLD 2>/dev/null)

if [ "$DRY_RUN" = true ]; then
    print_message "$YELLOW" "\n[DRY RUN] Would compress $COMPRESSED_COUNT files"
else
    print_message "$GREEN" "\nCompressed $COMPRESSED_COUNT files"
fi

print_message "$GREEN" "\n=========================================="
print_message "$GREEN" "Log Cleanup Completed!"
print_message "$GREEN" "=========================================="