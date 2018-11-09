FROM        mysql:5.7

# Proxy environment variables
ARG         http_proxy
ARG         https_proxy


# Set correct timezone
RUN         echo "Pacific/Auckland" > /etc/timezone
RUN         dpkg-reconfigure --frontend noninteractive tzdata

# Install and setup cron
RUN         apt-get update && apt-get install -y cron
ADD         crontab /crontab
RUN         /usr/bin/crontab /crontab
RUN         mkdir /var/log/cron

# Copy backup script
ADD         db-backup.sh /db-backup.sh
RUN         chmod +x /db-backup.sh

COPY        seed_db.py /docker-entrypoint-initdb.d
COPY        seed-db.sh /docker-entrypoint-initdb.d
RUN         chmod +x /docker-entrypoint-initdb.d/seed-db.sh

# Install dependencies that are required for loading data from a Python script
RUN         apt-get install -y python3 python3-pandas python3-pip libmysqlclient-dev
RUN         pip3 install mysqlclient xlrd pyyaml

# Install and setup supervisord
RUN         apt-get update && apt-get install -y supervisor
RUN         mkdir -p /var/log/supervisor
COPY        supervisord.conf /etc/supervisor/supervisord.conf

# Reset ENTRYPOINT because we are starting mysql with supervisord,
# not the ENTRYPOINT and CMD from the mysql docker container
ENTRYPOINT []

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
