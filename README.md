# Research Hub DB
A docker image for the [Research Hub](https://research-hub.auckland.ac.nz/) database. This Docker image runs MySQL, seeds the database and automatically backs up the database daily.

MySQL and Cron are run via Supervisord. Cron runs a script that dumps the MySQL database into the /data/ folder, which you can mount onto the host filesystem.

# Running the database container locally
Follow the instructions for running the database container locally in [Research Hub Deploy project](https://github.com/UoA-eResearch/research-hub-deploy#research-hub-deploy).

You should place the database spreadsheet in `config/db/database.xlsx` in the cloned Deploy project directory.

To build the database container:
```bash
./hubby build db
```

To run the database container:
```bash
./hubby up db
```

You can then examine the database using the MySQL client:
```bash
./hubby compose exec db bash
mysql -p
```
You can find the MySQL account password in [the Deploy project](https://github.com/UoA-eResearch/research-hub-deploy#research-hub-deploy).

If you make changes to the spreadsheet, you will need to run the following commands in order for the database container to reseed with the changed data:
```bash
./hubby cleandb
./hubby up db
```
You will be prompted for your sudo password on the `cleandb` step.
