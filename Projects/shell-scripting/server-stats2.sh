#!/bin/bash

echo "=============================="
echo "   SERVER PERFORMANCE STATS   "
echo "=============================="
echo ""

# -----------------------------
# CPU USAGE
# -----------------------------
echo "CPU Usage:"
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
printf "Total CPU Usage: %.2f%%\n" "$CPU_USAGE"
echo ""

# -----------------------------
# MEMORY USAGE
# -----------------------------
echo "Memory Usage:"
MEM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
MEM_USED=$(free -m | awk '/Mem:/ {print $3}')
MEM_FREE=$(free -m | awk '/Mem:/ {print $4}')
MEM_PERCENT=$(awk "BEGIN {printf \"%.2f\", ($MEM_USED/$MEM_TOTAL)*100}")

echo "Total: ${MEM_TOTAL}MB"
echo "Used : ${MEM_USED}MB (${MEM_PERCENT}%)"
echo "Free : ${MEM_FREE}MB"
echo ""

# -----------------------------
# DISK USAGE
# -----------------------------
echo "Disk Usage:"
df -h --total | awk '
/total/ {
  printf "Total: %s\nUsed : %s (%s)\nFree : %s\n", $2, $3, $5, $4
}'
echo ""

# -----------------------------
# TOP 5 CPU PROCESSES
# -----------------------------
echo "Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
echo ""

# -----------------------------
# TOP 5 MEMORY PROCESSES
# -----------------------------
echo "Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
echo ""

# -----------------------------
# STRETCH GOALS
# -----------------------------
echo "Additional Info:"
echo "OS Version:"
uname -a
echo ""

echo "Uptime:"
uptime
echo ""