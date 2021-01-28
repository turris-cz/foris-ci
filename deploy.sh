#!/bin/bash

docker login registry.nic.cz

docker build -t registry.nic.cz/turris/foris-ci/python3 .
docker push registry.nic.cz/turris/foris-ci/python3
