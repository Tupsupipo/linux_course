#!/usr/bin/env bash

set -euo pipefail

HTMLFILE="/home/ubuntu/projects/linux_course/viikko3/statuspage/viikko3.html"
DISK_STATE=""

if [[ -f "$HTMLFILE" ]]; then
  cp -- "$HTMLFILE" "$HTMLFILE.bak"
fi

disk_usage() {
  if df -h / | awk 'NR==2{print $5}' | grep -qE '^[8-9][0-9]%|^100%'; then
    DISK_STATE="<span style='color: #ff0000; font-weight: bold;'>WARNING!</span>: Disk usage is above <span style='color: #ff0000; font-weight: bold;'>80</span>%."
  else
   DISK_STATE="<span style='color: #00ff00; font-weight: bold;'>OK</span>: Disk usage is below <span style='color: #00ff00; font-weight: bold;'>80</span>%."
  fi
}

disk_usage

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

    td, th {
      border: 2px solid #91acd3;
      text-align: left;
      padding: 10px;
    }
    h1, h2 { color: #f0f2f3; }
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
      <td>Site information updated</td>
      <td>$(date '+%d.%m.%Y %H:%M %Z')</td>
    </tr>
    <tr>
      <td>Server uptime</td>
      <td>$(uptime -p)</td>
    </tr>
    <tr>
      <td>Memory usage</td>
      <td>$(free -h | awk 'NR==2{print $3 " / " $2}')</td>
    </tr>
    <tr>
      <td>Disk usage</td>
      <td>$(df -h / | awk 'NR==2{print $3 " / " $2 "  " $5 " of diskspace used"}')</td>
    </tr>
    <tr>
      <td>Disk health</td>
      <td>$DISK_STATE</td>
    </tr>
  </tbody>
</table>
    
</div>
</div>
  <div class="hyperbox">
    <p>Links:</p>
    <p><a href="https://github.com/Tupsupipo">    Project sourcecodes on GitHub</a></p>
    <p><a href="http://195.148.21.118">     Back to the week one</a></p>
    <p><a href="http://195.148.21.118/viikko2">     Back to the week two</a></p>
</div>
</body>
</html>

EOF

chmod 644 "$HTMLFILE"

