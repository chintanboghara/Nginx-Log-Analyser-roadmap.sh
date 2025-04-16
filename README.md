# Nginx Log Analyzer

**Nginx Log Analyzer** is a lightweight, command-line tool designed to parse and analyze Nginx access logs. It delivers quick insights into server traffic by identifying the top 5 entries for IP addresses, requested paths, response status codes, and user agents. This tool is ideal for monitoring server activity, troubleshooting issues, and understanding user behavior.

## Features

- **Top 5 IP Addresses:** Lists the IP addresses generating the most requests.
- **Top 5 Requested Paths:** Highlights the most frequently accessed URLs.
- **Top 5 Response Status Codes:** Shows the most common HTTP status codes returned by the server.
- **Top 5 User Agents:** Reveals the most frequent user agents (e.g., browsers or bots) interacting with your server.

Each section outputs results in the format:  
```
<item> - <count> requests
```  
**Example:**  
```
192.168.1.1 - 50 requests
```

## Installation

### Prerequisites

#### 1. Install Nginx
For Debian-based systems (e.g., Ubuntu), follow these steps:

- **Update Package List:**  
  ```bash
  sudo apt update
  ```

- **Install Nginx:**  
  ```bash
  sudo apt install nginx
  ```

- **Start Nginx:**  
  ```bash
  sudo systemctl start nginx
  ```

- **Enable on Boot:**  
  ```bash
  sudo systemctl enable nginx
  ```

- **Verify Status:**  
  ```bash
  sudo systemctl status nginx
  ```

#### 2. Install Required Tools
The script uses standard Unix tools, typically pre-installed on Linux systems. If missing, install them:

- **awk (gawk):**  
  ```bash
  sudo apt install gawk
  ```

- **sort, uniq, head (coreutils):**  
  ```bash
  sudo apt install coreutils
  ```

## Usage

1. **Save the Script:**  
   Save the script as `nginx_log_analyzer.sh`.

2. **Make Executable:**  
   ```bash
   chmod +x nginx_log_analyzer.sh
   ```

3. **Run the Script:**  
   ```bash
   ./nginx_log_analyzer.sh
   ```

**Note:** Ensure the log file path in the script matches your Nginx access log location (default: `/var/log/nginx/access.log`).

## Script Details

### 1. Define Log File
```bash
LOG_FILE="/var/log/nginx/access.log"  # Update this path if your log file is elsewhere
```
- Specifies the Nginx access log file to analyze.

### 2. Top 5 IP Addresses
```bash
echo "Top 5 IP addresses with the most requests:"
awk '{print $1}' $LOG_FILE | sort | uniq -c | sort -nr | head -n 5 | awk '{print $2 " - " $1 " requests"}'
echo ""
```
- Extracts the client IP (first field), counts occurrences, and lists the top 5.

### 3. Top 5 Requested Paths
```bash
echo "Top 5 most requested paths:"
awk '{print $7}' $LOG_FILE | sort | uniq -c | sort -nr | head -n 5 | awk '{print $2 " - " $1 " requests"}'
echo ""
```
- Pulls the requested path (seventh field) and identifies the top 5 by request count.

### 4. Top 5 Response Status Codes
```bash
echo "Top 5 response status codes:"
awk '{print $9}' $LOG_FILE | sort | uniq -c | sort -nr | head -n 5 | awk '{print $2 " - " $1 " requests"}'
echo ""
```
- Extracts the status code (ninth field) and ranks the top 5.

### 5. Top 5 User Agents
```bash
echo "Top 5 user agents:"
awk -F'"' '{print $6}' $LOG_FILE | sort | uniq -c | sort -nr | head -n 5 | awk '{print $2 " - " $1 " requests"}'
```
- Parses the user agent (sixth field between quotes) and lists the top 5.

## Example Output
```
Top 5 IP addresses with the most requests:
192.168.1.1 - 50 requests
10.0.0.5 - 45 requests
172.16.0.2 - 30 requests
8.8.8.8 - 20 requests
1.1.1.1 - 15 requests

Top 5 most requested paths:
/index.html - 60 requests
/about - 40 requests
/contact - 35 requests
/login - 25 requests
/blog - 20 requests

Top 5 response status codes:
200 - 150 requests
404 - 25 requests
301 - 15 requests
500 - 10 requests
403 - 5 requests

Top 5 user agents:
Mozilla/5.0 - 80 requests
Googlebot - 30 requests
curl/7.68.0 - 20 requests
Python-urllib/3.8 - 15 requests
Safari/605 - 10 requests
```

## Troubleshooting

- **Log File Not Found:**  
  - Verify the `LOG_FILE` path is correct and accessible.  
  - Check read permissions: `ls -l /var/log/nginx/access.log`.

- **No Output:**  
  - Ensure the log file contains data.  
  - Confirm the log format aligns with Nginx’s default structure.

- **Permission Denied:**  
  - Run the script with `sudo` if the log file is restricted.
