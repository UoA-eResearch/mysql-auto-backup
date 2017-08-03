# mysql-auto-backup
This project creates a Docker image that runs MySQL and also automatically backs up the database daily.

MySQL and Cron are run via Supervisord. Cron runs a script that dumps the MySQL database into the /data/ folder, which you can mount onto the host filesystem.

To deploy the Research Hub follow the instructions on the [Research Hub Deploy project](https://github.com/UoA-eResearch/research-hub-deploy#research-hub-deployment-project).
