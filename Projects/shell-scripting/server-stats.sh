#!/bin/bash

# Function to calculate and display CPU Usage
get_cpu_usage() {
    echo "------------------------------------------------"
    echo "CPU Usage"
    echo "------------------------------------------------"

    # we use 'top' in batch mode (-b) for one iteration (-n1)
    # we grep the line containing "Cpu(s)", scrape the idle percentage ($8 usually, but safe to grab by sting "id"),
    # subtract it from 100 to get used percentage.
    cpu_idle=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print $1}')
    cpu_usage=$(echo "100 - $cpu_idle" | bc)
    
    echo "Total CPU Usage: $cpu_usage%"
    printf "\n"
}

# Function to calculate and display Memory Usage
get_memory_usage() {
    echo "----------------------------------------"
    echo "Memory Usage"
    echo "----------------------------------------"
    
    # 'free -m' gives memory in MB. We use awk to calculate percentages.
    # $2=Total, $3=Used, $4=Free
    free -m | awk 'NR==2{printf "Total: %sMB | Used: %sMB (%.2f%%) | Free: %sMB (%.2f%%)\n", $2, $3, $3*100/$2, $4, $4*100/$2}'
    printf "\n"
}

# Function to calculate and display Disk Usage
get_disk_usage() {
    echo "----------------------------------------"
    echo "Disk Usage"
    echo "----------------------------------------"
    
    # 'df -h' gives human-readable disk stats. We exclude tmpfs/loops to keep it clean.
    # We are specifically looking at the root '/' or major mounted partitions.
    df -h | awk '$NF=="/"{printf "Total: %s | Used: %s (%s) | Free: %s\n", $2, $3, $5, $4}'
    printf "\n"
}

# Function to get Top 5 Processes by CPU
get_top_cpu_processes() {
    echo "----------------------------------------"
    echo "Top 5 Processes by CPU Usage"
    echo "----------------------------------------"
    
    # ps command fetches process stats. --sort=-%cpu sorts descending. head -n 6 includes header + 5 lines.
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
    printf "\n"
}

# Function to get Top 5 Processes by Memory
get_top_mem_processes() {
    echo "----------------------------------------"
    echo "Top 5 Processes by Memory Usage"
    echo "----------------------------------------"
    
    # Same as above but sorted by memory
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
    printf "\n"
}

# Stretch Goal: Extra Server Stats
get_extra_stats() {
    echo "----------------------------------------"
    echo "Extra Server Stats (Stretch Goal)"
    echo "----------------------------------------"
    
    echo "OS Version: $(cat /etc/os-release | grep -w "PRETTY_NAME" | cut -d= -f2 | tr -d '\"')"
    echo "Uptime: $(uptime -p)"
    echo "Load Average: $(uptime | awk -F'load average:' '{ print $2 }')"
    echo "Logged In Users: $(who | wc -l)"
    printf "\n"
}

# --- Main Execution ---
echo "========================================"
echo "   Server Performance Stats Analysis"
echo "========================================"

get_cpu_usage
get_memory_usage
get_disk_usage
get_top_cpu_processes
get_top_mem_processes
get_extra_stats

echo "========================================"
echo "Analysis Complete."