#!/usr/bin/env bash

set -euo pipefail

HTMLFILE="/home/ubuntu/projects/linux_course/viikko3/statuspage/viikko3.html"
DISK_HEALTH=""
DISK_PERCENT=$(df --output=pcent / | tail -1 | tr -dc '0-9')
MEM_USAGE=$(free | awk '/Mem:/ {printf "%.0f", $3/$2*100}')

if [[ -f "$HTMLFILE" ]]; then
  cp -- "$HTMLFILE" "$HTMLFILE.bak"
fi

disk_status() {
  if df -h / | awk 'NR==2{print $5}' | grep -qE '^[8-9][0-9]%|^100%'; then
    DISK_HEALTH="<span style='color: #ff0000; font-weight: bold;'>WARNING!</span>: Disk usage is above <span style='color: #ff0000; font-weight: bold;'>80</span>%."
  else
    DISK_HEALTH="<span style='color: #00ff00; font-weight: bold;'>OK</span>: Disk usage is below <span style='color: #00ff00; font-weight: bold;'>80</span>%."
  fi
}

disk_status

cat > "$HTMLFILE" <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>$(hostname)</title>
  <style>
    html {
      min-height: 100vh;
      background-image: url("static/images/serverroom.png");
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
      background-attachment: fixed;
    }

    body {
      max-width: 800px;
      margin: 40px auto;
      padding: 0 20px;
      font-family: sans-serif;
      line-height: 1.6;
      background: rgba(0, 0, 0, 0);
      color: #3ab855;
    }
    table {
      font-family: arial, sans-serif;
      border-collapse: collapse;
      width: 100%;
    }

    code {
    background-color: #1e293b;
    color: #00ff00;
    padding: 2px 6px;
    border-radius: 5px;
    font-family: Consolas, monospace;
    }

    td, th {
      border: 2px solid #91acd3;
      text-align: left;
      padding: 10px;
    }
    h1, h2 { color: #f0f2f3; }
    .progress {
      width: 100%;
      background: #333;
      border-radius: 8px;
      overflow: hidden;
    }

    .progress-fill {
      background: #3ab855;
      color: white;
      padding: 4px;
      text-align: center;
    }
    .textbox {
      background: rgba(8, 45, 75, 0.85);
      color: #f0f2f3;
      border-radius: 12px;
      padding: 20px 24px;
      margin-top: 24px;
      max-width: 100%;
      box-sizing: border-box;
      word-wrap: break-word;

    }
    .textbox h2 {
      margin: 0 0 10px;
      color: #f0f2f3;
    }
    .textbox p {
      margin: 0;
      color: #dfeaf6;
    }
    .hyperbox {
      background: rgba(90, 98, 110, 0.85);
      color: #f9fbfc;
      backdrop-filter: blur(5px);
      border-radius: 12px;
      padding: 20px 24px;
      margin-top: 24px;
      max-width: 100%;
      box-sizing: border-box;
      word-wrap: break-word;

    }
    .hyperbox p {
      margin: 0;
      color: hsl(75, 22%, 96%);
    }
    pre { background: #2c5d85; padding: 16px; overflow-x: auto; }
  </style>
</head>
<body>

  <div class="textbox">
    <h1>Week 3: Server status.</h1>
    <h1>Welcome to csc-linux server</h1>
    <h3>Work in progress...</h3>

    <table>
  <tbody>
    <tr>
      <td>Server status updated</td>
      <td>$(date '+%d.%m.%Y %H:%M %Z')</td>
    </tr>
    <tr>
      <td>Server uptime</td>
      <td>$(uptime -p)</td>
    </tr>
    <tr>
      <td>Memory</td>
      <td>$(free -h | awk '/Mem:/ {print "Used: " $3 " | Available: " $7 " | Total: " $2}') </td>
    </tr>
  <tr>
      <td>Memory usage</td>
      <td><div class="progress">
      <div class="progress-fill" style="width: ${MEM_USAGE}%">
      ${MEM_USAGE}%
      </div>
    </div></td>
    </tr>
    <tr>
      <td>Disk usage</td>
      <td><div class="progress">
      <div class="progress-fill" style="width: ${DISK_PERCENT}%">
      ${DISK_PERCENT}%
      </div>
    </div></td>
    </tr>
    <tr>
      <td>Disk health</td>
      <td>$DISK_HEALTH</td>
    </tr>
  </tbody>
</table>
  <h2>For this project I used following commands:</h2>
<ul>
  <li><code>date '+%d.%m.%Y %H:%M %Z'</code> : To get the current date, time and timezone </li>
  <li><code>uptime -p</code> : To get the uptime of the server </li>
  <li><code>free -h | awk '/Mem:/ {print "Used: " \$3 " | Available: " \$7 " | Total: " \$2}'</code> : To get the used, available and total memory </li>
  <li><code>free | awk '/Mem:/ {printf "%.0f", \$3/\$2*100}'</code> : To get the percentage of used memory </li>
  <li><code>df --output=pcent / | tail -1 | tr -dc '0-9'</code> : To get the percentage of used disk space </li>
</ul>
  <p>This script generates a status page in HTML format that displays the server's current status, including the date, time, timezone, uptime, memory usage, disk usage and disk health. </p>
  <p></p>
  <p>The script checks if the disk usage exceeds a certain threshold (80%) and displays a warning message if it does. Otherwise, it shows that the disk usage is OK.</p>
  <p>Disk space warning logic is implemented in the <code>disk_status</code> function. It checks the disk usage percentage and sets the <code>DISK_HEALTH</code> variable accordingly.</p>
  <p></p>
  
  <p>Script is timed to run every minute using a <strong>cron</strong> job, ensuring that the status page is always up-to-date.</p>
   <p></p>
  <p>All tests done were <strong>successful</strong> and the script works as <strong>expected</strong>. Bash syntax is correct. Script is working as expected after reboot. Disk space warning logic is working correctly. </p>
</div>
</div>
  <div class="hyperbox">
    <p>Links:</p>
    <p><a href="https://github.com/Tupsupipo/linux_course/tree/main/viikko3">    Project sourcecodes on GitHub</a></p>
    <p><a href="http://195.148.21.118">     Back to the week one</a></p>
    <p><a href="http://195.148.21.118/viikko2">     Back to the week two</a></p>
</div>
</body>
</html>

EOF

chmod 644 "$HTMLFILE"

