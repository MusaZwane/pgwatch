#!/bin/bash

docker-compose down
chmod 777 grafana
chmod 777 influx && chmod -R 777 logs/ && chmod 777 pg && chmod 777 pw2
docker-compose up -d --force-recreate
