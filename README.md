# research-hub-db
This project creates a Docker image that runs MySQL and also automatically backs up the database daily.

MySQL and Cron are run via Supervisord. Cron runs a script that dumps the MySQL database into the /data/ folder, which you can mount onto the host filesystem.

# Running the database container locally
Follow steps 1 and 2 from the [Research Hub Deploy project](https://github.com/UoA-eResearch/research-hub-deploy).

To build the database container:
```bash
./hubby compose build db
```

To run the database container:
```bash
./hubby compose run -p 3306:3306 db
```
