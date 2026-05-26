uptime
df -hT
free -h
echo "Top 5 processes by CPU usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
echo "Top 5 processes by Memory usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6