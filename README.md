# forensily
A suite of Tools of Live Forensics for - Linux (Bash) | 

# Forensic Data Collection Script

## Overview
This Bash script automates the collection of various forensic data from a Linux system, including:
- System login logs
- File operation logs
- Apache2 server logs
- Browser logs
- Browser saved passwords
- Network logs

The collected data is organized into an HTML report for easy review.

## Features
- Displays a custom ASCII art banner.
- Includes links to GitHub, LinkedIn, and Portfolio for reference.
- Prompts the user to confirm before starting the forensic operation.
- Checks for required tools and prompts the user to install them if missing.
- Collects data in a well-structured HTML format.

## Requirements
- Linux-based operating system
- Root permissions (for accessing system logs and file operation logs)
- Tools:
  - `last` (util-linux)
  - `ausearch` (auditd)
  - `journalctl` (systemd)

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/Dit-Developers/forensic-script.git
   cd forensic-script
   ```
2. Ensure the script has execute permissions:
   ```bash
   chmod +x forensic.sh
   ```

## Usage
1. Run the script:
   ```bash
   ./forensic.sh
   ```
2. The script will:
   - Display an ASCII art banner and reference links.
   - Prompt the user to confirm the forensic operation.
   - Check for and install required tools if missing.
   - Collect forensic data and save it to `forensic.html`.
3. Open the generated HTML report in a browser:
   ```bash
   xdg-open forensic.html
   ```

## Example Output
The `forensic.html` file will include sections such as:
- **System Login Logs**: Outputs from the `last` command.
- **File Operations Logs**: Outputs from `ausearch` related to file operations.
- **Apache2 Logs**: Contents of `/var/log/apache2/*.log`.
- **Browser Logs**: Log files from Firefox and Chrome.
- **Saved Passwords**: Extracted saved passwords (requires additional permissions).
- **Network Logs**: Logs from `NetworkManager`.

## Banner Example
```
███████╗ ██████╗ ██████╗ ███████╗███╗   ██╗███████╗██╗██╗  ██╗   ██╗
██╔════╝██╔═══██╗██╔══██╗██╔════╝████╗  ██║██╔════╝██║██║  ╚██╗ ██╔╝
█████╗  ██║   ██║██████╔╝█████╗  ██╔██╗ ██║███████╗██║██║   ╚████╔╝ 
██╔══╝  ██║   ██║██╔══██╗██╔══╝  ██║╚██╗██║╚════██║██║██║    ╚██╔╝  
██║     ╚██████╔╝██║  ██║███████╗██║ ╚████║███████║██║███████╗██║   
╚═╝      ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═══╝╚══════╝╚═╝╚══════╝╚═╝   
```

## References
- **GitHub**: [Dit-Developers](https://github.com/Dit-Developers/)
- **LinkedIn**: [Muhammad Sudais Usmani](https://www.linkedin.com/in/muhammad-sudais-usmani-950889311/)
- **Portfolio**: [Portfolio Website](https://msu-portfolio.vercel.app/)

## License
This script is released under the MIT License. Feel free to use and modify it as needed.
