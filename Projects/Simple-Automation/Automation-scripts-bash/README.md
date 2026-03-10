# DevOps Bash Automation Scripts - Learning Project

## 📚 Project Overview

This collection of Bash scripts demonstrates fundamental DevOps automation concepts. Each script is designed to teach you key scripting concepts while solving real-world problems.

## 🎯 Learning Objectives

By working through these scripts, you'll learn:

1. **Basic Bash Syntax**: Variables, conditionals, loops, functions
2. **Command Line Arguments**: Using getopts for flexible script options
3. **Error Handling**: Using `set -e` and proper exit codes
4. **Logging**: Creating audit trails for automation tasks
5. **User Interaction**: Prompts, confirmations, and colored output
6. **System Administration**: Package management, backups, monitoring
7. **Scheduling**: Using cron for automated task execution
8. **Best Practices**: Code organization, documentation, and reusability

---

## 📁 Scripts Included

### 1. log_cleanup.sh
**Purpose**: Automatically clean up old log files to free disk space

**Key Concepts**:
- File searching with `find` command
- Conditional logic for age-based deletion
- Dry-run mode for testing
- File compression with gzip
- Command-line argument parsing

**Usage**:
```bash
# Basic usage (dry run)
./log_cleanup.sh -n

# Delete logs older than 30 days
./log_cleanup.sh -d /var/log -t 30

# Custom directory and retention period
./log_cleanup.sh -d /path/to/logs -t 60
```

**Options**:
- `-d`: Directory to clean (default: /var/log)
- `-t`: Delete files older than X days (default: 30)
- `-n`: Dry run mode (show what would be deleted)
- `-h`: Help message

---

### 2. backup_automation.sh
**Purpose**: Create automated backups with compression and retention policies

**Key Concepts**:
- Using `tar` for creating archives
- Timestamp-based file naming
- Backup rotation (retention policy)
- Optional encryption with GPG
- Backup verification
- Manifest/log creation

**Usage**:
```bash
# Basic backup
./backup_automation.sh -s ~/documents -d ~/backups

# With 14-day retention
./backup_automation.sh -s ~/important_data -d ~/backups -r 14

# With encryption
./backup_automation.sh -s ~/sensitive -d ~/backups -e
```

**Options**:
- `-s`: Source directory to backup
- `-d`: Destination for backups
- `-r`: Retention period in days (default: 7)
- `-e`: Enable encryption (requires gpg)
- `-h`: Help message

---

### 3. system_update.sh
**Purpose**: Automate system package updates with logging

**Key Concepts**:
- Package manager detection (apt/yum/dnf)
- Root privilege checking
- Non-interactive updates
- Security-only updates option
- Reboot detection
- Comprehensive logging

**Usage**:
```bash
# Check for updates (no installation)
sudo ./system_update.sh -n

# Install updates interactively
sudo ./system_update.sh

# Auto-approve all updates
sudo ./system_update.sh -y

# Security updates only
sudo ./system_update.sh -s -y

# Auto-reboot if needed
sudo ./system_update.sh -y -r
```

**Options**:
- `-y`: Auto-approve updates
- `-r`: Reboot if required
- `-s`: Security updates only
- `-n`: Check only (no installation)
- `-h`: Help message

**Note**: Requires root/sudo privileges

---

### 4. disk_monitor.sh
**Purpose**: Monitor disk space and alert when thresholds are exceeded

**Key Concepts**:
- Parsing `df` command output
- Threshold-based alerting
- Email notifications (optional)
- Finding largest directories
- Exit codes for scripting integration

**Usage**:
```bash
# Check all partitions (80% threshold)
./disk_monitor.sh

# Custom threshold (90%)
./disk_monitor.sh -t 90

# With email alerts
./disk_monitor.sh -t 85 -e admin@example.com

# Check specific partition
./disk_monitor.sh -p /dev/sda1 -t 75
```

**Options**:
- `-t`: Threshold percentage (default: 80)
- `-e`: Email address for alerts
- `-p`: Check specific partition
- `-l`: Custom log file location
- `-h`: Help message

---

### 5. automation_manager.sh
**Purpose**: Master script to orchestrate all automation tasks

**Key Concepts**:
- Script orchestration
- Menu-driven interface
- Cron job management
- Report generation
- Error aggregation
- Modular design

**Usage**:
```bash
# Run all automation tasks
./automation_manager.sh all

# Individual tasks
./automation_manager.sh backup
./automation_manager.sh monitor
./automation_manager.sh logs

# Setup cron jobs
./automation_manager.sh schedule

# Generate system report
./automation_manager.sh report

# Get help
./automation_manager.sh help
```

**Commands**:
- `all`: Run all automation scripts
- `logs`: Clean up old log files
- `backup`: Run backup automation
- `update`: Run system updates (requires sudo)
- `monitor`: Check disk space
- `schedule`: Setup cron jobs
- `report`: Generate automation report
- `help`: Display help message

---

## 🚀 Getting Started

### Prerequisites

1. **Linux/Unix System**: Ubuntu, Debian, CentOS, Fedora, etc.
2. **Bash Shell**: Version 4.0 or higher
3. **Basic Tools**: Should be installed by default
   - `tar`, `gzip`, `find`, `df`, `du`
4. **Optional Tools**:
   - `gpg` (for encryption in backup script)
   - `mail` (for email alerts in disk monitor)

### Installation

1. **Download the scripts** (already in your directory)

2. **Make scripts executable**:
```bash
chmod +x *.sh
```

3. **Verify scripts**:
```bash
# Check all scripts are executable
ls -lh *.sh
```

---

## 📖 Step-by-Step Learning Path

### Week 1: Understanding Basics

1. **Read through log_cleanup.sh**
   - Focus on: variables, conditionals, loops
   - Try: Run with `-n` (dry run) to see output
   - Experiment: Change the retention period

2. **Study the functions**
   - Look at `print_message()` function
   - Understand how `getopts` works
   - Practice: Add a new command-line option

### Week 2: Working with Files

3. **Explore backup_automation.sh**
   - Understand `tar` command usage
   - Learn about timestamps and file naming
   - Try: Create backups of test directories
   - Challenge: Modify to backup to remote location

4. **Test backup features**
   - Run with different retention periods
   - Try encryption option
   - Verify backup integrity

### Week 3: System Administration

5. **Analyze system_update.sh**
   - Study package manager detection
   - Understand privilege checking
   - Try: Run in check-only mode first
   - Learn: How to parse command output

6. **Practice disk_monitor.sh**
   - Understand threshold monitoring
   - Learn to parse `df` output
   - Experiment: Set different thresholds
   - Challenge: Add more disk metrics

### Week 4: Automation & Orchestration

7. **Master automation_manager.sh**
   - Study script orchestration
   - Learn about cron jobs
   - Try: Setup automated schedules
   - Practice: Generate system reports

---

## 🔧 Customization Ideas

### Beginner Modifications

1. **Add more logging**:
   - Log to syslog
   - Create separate error logs
   - Add log rotation

2. **Improve output**:
   - Add progress bars
   - Create summary tables
   - Add more colors/formatting

3. **Extend functionality**:
   - Add more command-line options
   - Create configuration files
   - Add interactive menus

### Intermediate Modifications

4. **Add notifications**:
   - Slack/Discord webhooks
   - SMS alerts (using APIs)
   - Desktop notifications

5. **Remote operations**:
   - SSH to remote servers
   - Backup to cloud storage (S3, Google Drive)
   - Monitor multiple servers

6. **Database integration**:
   - Store metrics in SQLite
   - Generate historical reports
   - Create dashboards

### Advanced Modifications

7. **Parallel execution**:
   - Run tasks concurrently
   - Implement job queues
   - Add resource limits

8. **Error recovery**:
   - Implement retry logic
   - Add rollback mechanisms
   - Create checkpoints

9. **Monitoring & Alerting**:
   - Integrate with monitoring tools
   - Create health checks
   - Build status dashboards

---

## 🎓 Key Bash Concepts Demonstrated

### 1. Variables
```bash
# Simple variable
NAME="value"

# Command substitution
CURRENT_DATE=$(date +%Y%m%d)

# Arrays
FILES=("file1" "file2" "file3")
```

### 2. Conditionals
```bash
# If statement
if [ "$VALUE" -gt 10 ]; then
    echo "Greater than 10"
elif [ "$VALUE" -eq 10 ]; then
    echo "Equal to 10"
else
    echo "Less than 10"
fi

# Case statement
case $OPTION in
    start) start_service ;;
    stop) stop_service ;;
    *) echo "Unknown option" ;;
esac
```

### 3. Loops
```bash
# For loop
for file in *.txt; do
    echo "Processing $file"
done

# While loop with read
while IFS= read -r line; do
    echo "$line"
done < file.txt

# While with find
find . -name "*.log" | while read -r file; do
    process "$file"
done
```

### 4. Functions
```bash
# Function definition
my_function() {
    local param=$1  # Local variable
    echo "Parameter: $param"
    return 0  # Exit code
}

# Function call
my_function "value"
```

### 5. Error Handling
```bash
# Exit on error
set -e

# Custom error handling
if ! command; then
    echo "Error occurred"
    exit 1
fi

# Try-catch equivalent
{
    risky_command
} || {
    echo "Command failed"
    handle_error
}
```

---

## 📊 Scheduling with Cron

### Cron Syntax
```
┌───────────── minute (0 - 59)
│ ┌───────────── hour (0 - 23)
│ │ ┌───────────── day of month (1 - 31)
│ │ │ ┌───────────── month (1 - 12)
│ │ │ │ ┌───────────── day of week (0 - 6) (Sunday=0)
│ │ │ │ │
* * * * * command to execute
```

### Example Cron Jobs
```bash
# Daily backup at 2 AM
0 2 * * * /path/to/backup_automation.sh

# Hourly disk monitoring
0 * * * * /path/to/disk_monitor.sh

# Weekly log cleanup on Sundays at 3 AM
0 3 * * 0 /path/to/log_cleanup.sh

# Every 15 minutes
*/15 * * * * /path/to/some_script.sh
```

### Setup Cron Jobs
```bash
# Edit crontab
crontab -e

# List current cron jobs
crontab -l

# Remove all cron jobs
crontab -r
```

---

## 🐛 Troubleshooting

### Common Issues

1. **Permission Denied**
   ```bash
   # Solution: Make script executable
   chmod +x script.sh
   ```

2. **Command Not Found**
   ```bash
   # Solution: Use full path or check if command exists
   command -v tool_name &> /dev/null || echo "Not installed"
   ```

3. **Script Not Running in Cron**
   ```bash
   # Solution: Use absolute paths
   /full/path/to/script.sh
   
   # Check cron logs
   grep CRON /var/log/syslog
   ```

4. **No Space Left on Device**
   ```bash
   # Check disk space
   df -h
   
   # Find large files
   du -sh /* | sort -h
   ```

---

## 🔐 Security Best Practices

1. **Never hardcode passwords**
   - Use environment variables
   - Use configuration files with restricted permissions
   - Consider using secret management tools

2. **Validate user input**
   ```bash
   if [[ ! "$INPUT" =~ ^[0-9]+$ ]]; then
       echo "Invalid input"
       exit 1
   fi
   ```

3. **Use secure file permissions**
   ```bash
   # Scripts: rwxr-xr-x (755)
   chmod 755 script.sh
   
   # Config files with secrets: rw------- (600)
   chmod 600 config.ini
   ```

4. **Avoid using `sudo` unnecessarily**
   - Run with minimum required privileges
   - Use specific sudo rules if needed

---

## 📚 Additional Resources

### Documentation
- [Bash Manual](https://www.gnu.org/software/bash/manual/)
- [Advanced Bash-Scripting Guide](https://tldp.org/LDP/abs/html/)
- [ShellCheck](https://www.shellcheck.net/) - Script analysis tool

### Practice
- [Linux Journey](https://linuxjourney.com/)
- [OverTheWire: Bandit](https://overthewire.org/wargames/bandit/)
- [Bash Exercises](https://exercism.org/tracks/bash)

### Tools
- `shellcheck` - Static analysis for shell scripts
- `bash -x` - Debug mode (trace execution)
- `set -e` - Exit on error
- `set -u` - Exit on undefined variable
- `set -o pipefail` - Catch errors in pipes

---

## 🎯 Next Steps

After mastering these scripts, consider:

1. **Version Control**: Learn Git for tracking changes
2. **Configuration Management**: Explore Ansible, Puppet, or Chef
3. **Containerization**: Learn Docker and container orchestration
4. **CI/CD**: Study Jenkins, GitLab CI, or GitHub Actions
5. **Infrastructure as Code**: Terraform, CloudFormation
6. **Monitoring**: Prometheus, Grafana, ELK Stack
7. **Cloud Platforms**: AWS, Azure, Google Cloud

---

## 🤝 Contributing

Feel free to:
- Modify scripts for your use case
- Add new features
- Improve error handling
- Enhance documentation
- Share your improvements

---

## 📝 License

These scripts are provided as educational material for learning DevOps and Bash scripting. Feel free to use, modify, and distribute them for learning purposes.

---

## 📧 Support

If you have questions or need help:
1. Read the script comments carefully
2. Test with `-h` flag for help
3. Use dry-run modes (`-n`) to test safely
4. Check system logs for errors
5. Review the troubleshooting section

---

**Happy Learning! 🚀**

Remember: The best way to learn is by doing. Start with small modifications, break things (safely!), fix them, and gradually build your confidence.