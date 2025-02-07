#!/bin/bash

# Start logging
echo "==================== System Report ====================" > log.txt
echo "Generating system metrics and process statistics..." >> log.txt
echo "-------------------------------------------------------" >> log.txt

# CPU Usage
echo ">> CPU Usage:" >> log.txt
mpstat 1 1 | grep "all" | awk '{ print "CPU Usage Percentage: " 100 - $NF"%"; exit; }' >> log.txt
echo "" >> log.txt

# Memory Usage
echo ">> Memory Usage:" >> log.txt
free -m | grep Mem | awk '{printf "Free Memory: %.2f%%\n", $4/$2*100}' >> log.txt
echo "" >> log.txt

# Disk Space
echo ">> Disk Space Usage (/home):" >> log.txt
df -h | grep /home | awk '{print "Free Space: " 100-$5 "%"}' >> log.txt
echo "" >> log.txt

# Processes Using Most CPU
echo ">> Processes Using Most CPU:" >> log.txt
echo "PID    USER      COMMAND                              CPU%" >> log.txt
ps -eo pid,user,args,pcpu --sort=-%cpu | head -n 6 >> log.txt
echo "" >> log.txt

# Processes Using Most Memory
echo ">> Processes Using Most Memory:" >> log.txt
echo "PID    USER      COMMAND                              MEM (KB)" >> log.txt
ps -eo pid,user,args,size --sort=-%mem | head -n 6 >> log.txt
echo "" >> log.txt

# End logging
echo "==================== End of Report ====================" >> log.txt

# Display the report
cat log.txt

