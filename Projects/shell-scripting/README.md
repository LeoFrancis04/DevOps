# Server Performance Stats

A Bash script to analyze basic server performance statistics.

## Features
    - CPU usage
    - Memory usage
    - Disk usage
    - Top 5 CPU consuming processes
    - Top 5 Memory consuming processes
    - OS version, uptime and Load Average

## How to Run
```bash
chmod +x server-stats.sh
./server-stats.sh
```

## Explanation of the Code 
    Here is the breakdown of specific tools for each requirement, ensuring the script works on any Linux server (Ubuntu, CentOS, Debian, etc.) without needing third-party tools like htop.

## 1. CPU Usage
    - Command: top -bn1

    - Why: top is available on every Linux system. Running it in "batch mode" (-b) ensures it prints the output to stdout instead of opening an interactive window.

    - Logic: I grep for the "Cpu(s)" line, find the "idle" percentage, and subtract it from 100. This is the most reliable way to get "Total Usage" without installing sysstat (mpstat).

## 2. Memory Usage
    - Command: free -m

    - Why: This is the standard command for memory stats. The -m flag displays values in Megabytes, which is easier to read than bytes.

    - Logic: I used awk to perform the math (Used / Total * 100) right inside the command to generate the percentage dynamically.

## 3. Disk Usage
    - Command: df -h

    - Why: df reports file system disk space usage. -h makes it "human-readable" (G for Gigabytes, M for Megabytes).

    - Logic: I filtered specifically for the root directory (/) using awk '$NF=="/". Without this filter, df often lists dozens of "loop" and "tmpfs" partitions that clutter the output and aren't relevant to general disk performance.

## 4. Top 5 Processes (CPU & Mem)
    - Command: ps -eo ...

    - Why: ps provides a snapshot of current processes.

        -e: Select all processes.

        -o: Output specific columns (pid, ppid, cmd, %mem, %cpu) to keep the table clean.

        --sort=-%cpu: Sorts the output by CPU usage in descending order (highest first).

        - head -n 6: Grabs the top 6 lines (1 header line + 5 processes).

## 5. Stretch Goals (Extra Stats)
    - OS Version: Reads from /etc/os-release, which is the standard file for Linux distribution info.

    - Uptime: Uses uptime -p for a "pretty" readable format (e.g., "up 2 weeks, 3 days").

    - Load Average: Extracted from the uptime command using awk.