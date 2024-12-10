#!/bin/bash

# Define the output file
OUTPUT_FILE="forensic.html"

# ASCII Art Banner
echo -e "\e[33m"
echo "███████╗ ██████╗ ██████╗ ███████╗███╗   ██╗███████╗██╗██╗  ██╗   ██╗"
echo "██╔════╝██╔═══██╗██╔══██╗██╔════╝████╗  ██║██╔════╝██║██║  ╚██╗ ██╔╝"
echo "█████╗  ██║   ██║██████╔╝█████╗  ██╔██╗ ██║███████╗██║██║   ╚████╔╝ "
echo "██╔══╝  ██║   ██║██╔══██╗██╔══╝  ██║╚██╗██║╚════██║██║██║    ╚██╔╝  "
echo "██║     ╚██████╔╝██║  ██║███████╗██║ ╚████║███████║██║███████╗██║   "
echo "╚═╝      ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═══╝╚══════╝╚═╝╚══════╝╚═╝   "
echo -e "\e[0m"

# Display links
echo "Github: https://github.com/Dit-Developers/"
echo "LinkedIn: https://www.linkedin.com/in/muhammad-sudais-usmani-950889311/"
echo "Portfolio: https://msu-portfolio.vercel.app/"

# Ask user to confirm forensic operation
read -p "Do you want to perform the forensic operation? (Y/n): " RESPONSE
if [[ "$RESPONSE" =~ ^[Nn]$ ]]; then
  echo "Forensic operation canceled."
  exit 0
fi

# Function to check and install required tools
check_and_install() {
  TOOL=$1
  PACKAGE=$2
  if ! command -v $TOOL &>/dev/null; then
    echo "$TOOL is not installed. Do you want to install it? [Y/n]"
    read -r RESPONSE
    if [[ "$RESPONSE" =~ ^[Yy]$ || -z "$RESPONSE" ]]; then
      sudo apt update && sudo apt install -y $PACKAGE
    else
      echo "$TOOL will not be installed. Skipping..."
    fi
  else
    echo "$TOOL is already installed."
  fi
}

# Check and install required tools
check_and_install "last" "util-linux"
check_and_install "ausearch" "auditd"
check_and_install "journalctl" "systemd"

# Create and initialize the HTML file
echo "<html>" > $OUTPUT_FILE
echo "<head><title>Forensic Report</title></head>" >> $OUTPUT_FILE
echo "<body><h1>Forensic Report</h1>" >> $OUTPUT_FILE

# 1. System login logs
echo "<h2>System Login Logs</h2>" >> $OUTPUT_FILE
echo "<pre>" >> $OUTPUT_FILE
last >> $OUTPUT_FILE
echo "</pre>" >> $OUTPUT_FILE

# 2. File operations logs (auditd)
echo "<h2>File Operations Logs</h2>" >> $OUTPUT_FILE
echo "<pre>" >> $OUTPUT_FILE
ausearch -m FILE >> $OUTPUT_FILE 2>/dev/null
echo "</pre>" >> $OUTPUT_FILE

# 3. Apache2 logs
echo "<h2>Apache2 Logs</h2>" >> $OUTPUT_FILE
echo "<pre>" >> $OUTPUT_FILE
if [ -d "/var/log/apache2" ]; then
  cat /var/log/apache2/*.log >> $OUTPUT_FILE
else
  echo "Apache2 logs not found." >> $OUTPUT_FILE
fi
echo "</pre>" >> $OUTPUT_FILE

# 4. Browser logs
echo "<h2>Browser Logs</h2>" >> $OUTPUT_FILE
echo "<pre>" >> $OUTPUT_FILE
BROWSER_LOGS=$(find ~/.mozilla/firefox ~/.config/google-chrome -name "*.log" 2>/dev/null)
if [ ! -z "$BROWSER_LOGS" ]; then
  cat $BROWSER_LOGS >> $OUTPUT_FILE
else
  echo "No browser logs found." >> $OUTPUT_FILE
fi
echo "</pre>" >> $OUTPUT_FILE

# 5. Browser saved passwords (requires additional permissions/tools)
echo "<h2>Browser Saved Passwords</h2>" >> $OUTPUT_FILE
echo "<pre>" >> $OUTPUT_FILE
if [ -f ~/.mozilla/firefox/*.default-release/logins.json ]; then
  cat ~/.mozilla/firefox/*.default-release/logins.json >> $OUTPUT_FILE
else
  echo "No saved passwords found (requires manual extraction)." >> $OUTPUT_FILE
fi
echo "</pre>" >> $OUTPUT_FILE

# 6. Network logs
echo "<h2>Network Logs</h2>" >> $OUTPUT_FILE
echo "<pre>" >> $OUTPUT_FILE
journalctl -u NetworkManager >> $OUTPUT_FILE 2>/dev/null
echo "</pre>" >> $OUTPUT_FILE

# Finalize the HTML
echo "</body></html>" >> $OUTPUT_FILE

# Notify the user
echo "Forensic report saved to $OUTPUT_FILE"
