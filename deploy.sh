#!/bin/bash

docker login registry.labs.nic.cz

docker build -t registry.labs.nic.cz/turris/foris-ci/python3 .
docker push registry.labs.nic.cz/turris/foris-ci/python3
