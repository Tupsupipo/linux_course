# Week 4 on linux course. 
# Server backup and database mirroring
This weeks task was to clone our linux server to another server. On the clone server we were tasked to show a mirror of a week 2 visitor counter. 
This was done by replicating the database of a counter to the new server and showing the counter from read only database so that week4 site cant increment the counter.
## Task Requirements:

    1. Create server B by copying server A.

    Create a new virtual machine in cPouta using a snapshot of A. B must have its own IP address. You may alternatively use another server or hosting environment; document how you transferred the required files, settings and database.

    Keep A’s Week 2 application and Week 3 report running at their original URLs.

    2. Configure hourly website backups from A to B.

    Use cron to back up A’s /var/www/html directory to B once per hour. Preserve at least two timestamped backup versions and record whether each run succeeds.

    Store backups outside publicly served directories and protect them with appropriate ownership and permissions. Verify at least two automatic backup runs and successfully restore one test file to a separate location.

    3. Configure continuous MariaDB replication from A to B.

    Changes to A’s application database must automatically appear in B’s local database. Keep B’s database read-only for ordinary application users.

    Use dedicated credentials and appropriate access restrictions. Explain why continuous replication does not replace historical backups.

    4. Display the replicated visitor counter on B.

    Use the Week 2 application to demonstrate replication:

       * A’s /viikko2/ page increments the counter when loaded.

       * B’s /viikko4/ page displays the counter from B’s local replicated database.

       * Loading B’s page must not increment the counter or otherwise modify the database.

       * B’s page must clearly identify itself as a read-only replica.

    After A’s counter changes, the updated value must appear on B when its page is reloaded. A short replication delay is acceptable.

    5. Test the implementation.

    Verify and document that:

       * both pages are publicly accessible

       * loading A’s page updates the counter displayed on B

       * loading B’s page does not increment the counter

       * database replication reports normal operation

       * at least two scheduled file backups succeed

       * a restored test file matches the original

       * B’s website, replication and backup schedule continue working after B is rebooted.

    6. Document your work on B’s Week 4 page.

    Include:

       * links to both submitted counter pages

       * a description of how B was created

       * a summary of both servers’ storage layout and backup locations

       * an explanation of the Linux users, database users, ownership and      permissions used

       * a description of the hourly backup schedule and continuous replication

       * the required test results

       * one problem you solved or one thing you learned.

    7. Use GitHub for version control.

      Store your backup script, cron configuration, sanitised replication configuration and B’s application changes in a repository. Include a README, make descriptive commits and link the repository from B’s page.

      Do not publish backup archives, SQL dumps, passwords, private keys or other secrets on the website or GitHub.
