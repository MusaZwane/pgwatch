#!/bin/bash

echo "Bringing down the project"


docker-compose down


for i in grafana influx logs/ pg pw2;
do
	chmod -R 777 $i;
done

docker-compose up -d --force-recreate
