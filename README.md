# mysql-auto-backup
This project creates a Docker image that runs MySQL and also automatically backs up the database daily.

MySQL and Cron are run via Supervisord. Cron runs a script that dumps the MySQL database into the /data/ folder, which you can mount onto the host filesystem.
