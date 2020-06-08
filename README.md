# PGWATCH

INSTALLING

For the fastest installation / setup experience Docker images are provided via Docker Hub (for a Docker quickstart see here). For doing a custom setup see the "Installing without Docker" paragraph below or turn to the "releases" tab for DEB / RPM / Tar packages.

# fetch and run the latest Docker image, exposing Grafana on port 3000 and administrative web UI on 8080
docker run -d -p 3000:3000 -p 8080:8080 -e PW2_TESTDB=true --name pw2 cybertec/pgwatch2
After some minutes you could open the "db-overview" dashboard and start looking at metrics. For defining your own dashboards you need to log in as admin (admin/pgwatch2admin). NB! If you don't want to add the "test" database (the pgwatch2 configuration db) for monitoring set the NOTESTDB=1 env parameter when launching the image.

For production setups without a container management framework also "--restart unless-stopped" (or custom startup scripts) is highly recommended. Also exposing the config/metrics database ports for backups and usage of volumes is then recommended to enable easier updating to newer pgwatch2 Docker images without going through the backup/restore procedure described towards the end of README. For maximum flexibility, security and update simplicity though, best would to do a custom setup - see paragraph "Installing without Docker" towards the end of README for that.

for v in pg influx grafana pw2 ; do docker volume create $v ; done
# with InfluxDB for metrics storage
docker run -d --name pw2 -v pg:/var/lib/postgresql -v influx:/var/lib/influxdb -v grafana:/var/lib/grafana -v pw2:/pgwatch2/persistent-config -p 8080:8080 -p 3000:3000 -e PW2_TESTDB=true cybertec/pgwatch2
# with Postgres for metrics storage
docker run -d --name pw2 -v pg:/var/lib/postgresql -v grafana:/var/lib/grafana -v pw2:/pgwatch2/persistent-config -p 8080:8080 -p 3000:3000 -e PW2_TESTDB=true cybertec/pgwatch2-postgres
For more advanced usecases (production setup with backups) or for easier problemsolving you can decide to expose all services

# run with all ports exposed
docker run -d --restart unless-stopped -p 3000:3000 -p 5432:5432 -p 8086:8086 -p 8080:8080 -p 8081:8081 -p 8088:8088 -v ... --name pw2 cybertec/pgwatch2
NB! For production usage make sure you also specify listening IPs explicitly (-p IP:host_port:container_port), by default Docker uses 0.0.0.0 (all network devices).

For custom options, more security, or specific component versions one could easily build the image themselves, just Docker needed:

