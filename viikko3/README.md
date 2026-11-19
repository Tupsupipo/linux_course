# Week 3 on linux course. 
# Bash script for updating server status on website.

## Task requirements: 
    Implementation

    1. Keep your Week 2 application running at its original URL for at least one more week.

    2. Start by practising commands on the command line. Find out how to display:

       * the current date, time and time zone

       * the server’s uptime

       * disk usage for the root filesystem (/) as a percentage

       * total and available RAM.

    Useful commands include date, uptime, df and free. Also practise piping (|) and processing command output using tools such as awk, grep or cut.

    3. Create a Bash script that collects the information listed above and generates an HTML report. Publish the report at a URL such as:

    http://PUBLIC_IP/viikko3/

    The report must include all the information listed above, with clear labels and appropriate units. The date and time must indicate when the report was generated.

    Also include a disk space status based on the root filesystem’s usage percentage:

       * OK when usage is below 80%

       * WARNING when usage is at least 80%.

    Your script must use:

       * the Bash interpreter, for example #!/usr/bin/env bash

       * variables and command substitution to store command output ($(...))

       * at least one pipe between commands

       * an if statement to determine the disk space status

       * at least one function that you define and call.

    Use Bash and Linux commands to collect the information and generate the report.

    4. Schedule the report to update once per minute using either cron or a systemd timer. Make sure the schedule continues to work after the virtual machine is rebooted.

    Loading the page displays the most recently generated report. After waiting approximately 1–2 minutes and reloading the page, the peer reviewer must see a new generation time.

    5. Test the script and the schedule.

       * Check the syntax using bash -n script_name.sh.

       * Run the script manually and check the report in a browser.

       * Test both branches of the disk space status logic using, for example, 50%, 80% and 90% as test values. The expected results are OK, WARNING and WARNING, respectively. Temporarily use these values as input to the status logic; you do not need to fill the disk. Restore the actual disk usage percentage afterwards.

       * Verify that at least two automatic updates take place.

       * Reboot the virtual machine and verify that the website opens and automatic report updates continue.

    6. Document your work on the website. Include the following alongside the report:

       * at least three commands you used, with a short explanation of each; at least one example must include piping

       * a short description of how the script, disk space status logic and schedule work

       * test results, including the disk space status tests and the reboot test

       * one problem you encountered and how you solved it, or one thing you learned.

    The documentation may be on the report page or on a separate page linked from it. Personalise the page’s content or appearance.

    7. Use GitHub for version control. Store your Bash script and either your cron configuration or your systemd service and timer configurations in a repository. Make descriptive commits as your work progresses and add a link to the repository on your website.

    Publish only the status information required for this assignment. Do not publish passwords, private keys, environment variable contents or other secrets on your website or GitHub.
