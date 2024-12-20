# Explanation:

### 1. **Define Log File**
```bash
LOG_FILE="/var/log/nginx/access.log"  # Replace with the actual path of the log file
```
- The log file path is defined here (`/var/log/nginx/access.log`). You can replace this with the actual path of your Nginx log file.

### 2. **Top 5 IP Addresses with the Most Requests**
```bash
echo "Top 5 IP addresses with the most requests:"
awk '{print $1}' $LOG_FILE | sort | uniq -c | sort -nr | head -n 5 | awk '{print $2 " - " $1 " requests"}'
echo ""
```
- **`awk '{print $1}'`**: Extracts the first field from each line in the log file, which is the IP address of the client making the request.
- **`sort`**: Sorts the IP addresses.
- **`uniq -c`**: Counts the occurrences of each unique IP address.
- **`sort -nr`**: Sorts the results numerically in reverse order (most requests first).
- **`head -n 5`**: Limits the output to the top 5 IP addresses.
- **`awk '{print $2 " - " $1 " requests"}'`**: Formats the output to display the IP address and the number of requests.

### 3. **Top 5 Most Requested Paths**
```bash
echo "Top 5 most requested paths:"
awk '{print $7}' $LOG_FILE | sort | uniq -c | sort -nr | head -n 5 | awk '{print $2 " - " $1 " requests"}'
echo ""
```
- **`awk '{print $7}'`**: Extracts the seventh field from each line, which corresponds to the requested path (e.g., `/index.html`).
- The rest of the commands are similar to the previous section, counting and sorting the most requested paths.

### 4. **Top 5 Response Status Codes**
```bash
echo "Top 5 response status codes:"
awk '{print $9}' $LOG_FILE | sort | uniq -c | sort -nr | head -n 5 | awk '{print $2 " - " $1 " requests"}'
echo ""
```
- **`awk '{print $9}'`**: Extracts the ninth field from each line, which is the response status code (e.g., `200`, `404`).
- Similar processing as before to count and sort the status codes.

### 5. **Top 5 User Agents**
```bash
echo "Top 5 user agents:"
awk -F'"' '{print $6}' $LOG_FILE | sort | uniq -c | sort -nr | head -n 5 | awk '{print $2 " - " $1 " requests"}'
```
- **`awk -F'"' '{print $6}'`**: Sets the field separator to `"` (double quote) and extracts the 6th field, which corresponds to the user agent string (the client software or browser used for the request).
- Again, similar processing to count and sort the most frequent user agents.

### Output:
- The script prints the top 5 results for IP addresses, requested paths, response status codes, and user agents, formatted as:
  - `<item> - <count> requests`
  - For example: `192.168.1.1 - 50 requests`

# How to Use:
1. Save the script to a file, e.g., `nginx_log_analyzer.sh`.
2. Make the script executable:
   ```bash
   chmod +x nginx_log_analyzer.sh
   ```
3. Run the script:
   ```bash
   ./nginx_log_analyzer.sh
   ```

# Installation:

### 1. **Nginx**

#### Step 1: Update Package List
Open a terminal and run the following command to update the package index:

```bash
sudo apt update
```

#### Step 2: Install Nginx
Install Nginx using the `apt` package manager:

```bash
sudo apt install nginx
```

#### Step 3: Start Nginx
Once installed, you can start the Nginx service:

```bash
sudo systemctl start nginx
```

#### Step 4: Enable Nginx to Start on Boot
To ensure Nginx starts automatically when the system boots:

```bash
sudo systemctl enable nginx
```

#### Step 5: Check the Status of Nginx
To verify that Nginx is running:

```bash
sudo systemctl status nginx
```

### 2. **awk**
  ```bash
  sudo apt install gawk
  ```

### 3. **sort**
  ```bash
  sudo apt install coreutils
  ```
  
### 4. **uniq**
  ```bash
  sudo apt install coreutils
  ```

### 5. **head**
  ```bash
  sudo apt install coreutils
  ```
  
## Example Output
![Output](https://github.com/user-attachments/assets/e598f76b-9838-4ab7-9bb2-dd47a4d4c1bf)

