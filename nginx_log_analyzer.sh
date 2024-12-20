#!/bin/bash

# Define log file
LOG_FILE="/var/log/nginx/access.log"

# Top 5 IP addresses with the most requests
echo "Top 5 IP addresses with the most requests:"
awk '{print $1}' $LOG_FILE | sort | uniq -c | sort -nr | head -n 5 | awk '{print $2 " - " $1 " requests"}'
echo ""

# Top 5 most requested paths
echo "Top 5 most requested paths:"
awk '{print $7}' $LOG_FILE | sort | uniq -c | sort -nr | head -n 5 | awk '{print $2 " - " $1 " requests"}'
echo ""

# Top 5 response status codes
echo "Top 5 response status codes:"
awk '{print $9}' $LOG_FILE | sort | uniq -c | sort -nr | head -n 5 | awk '{print $2 " - " $1 " requests"}'
echo ""

# Top 5 user agents
echo "Top 5 user agents:"
awk -F'"' '{print $6}' $LOG_FILE | sort | uniq -c | sort -nr | head -n 5 | awk '{print $2 " - " $1 " requests"}'
