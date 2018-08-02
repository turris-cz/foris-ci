#!/bin/bash

docker login registry.labs.nic.cz

cd python2
docker build -t registry.labs.nic.cz/turris/foris-ci/python2 .
docker push registry.labs.nic.cz/turris/foris-ci/python2

cd ../python3
docker build -t registry.labs.nic.cz/turris/foris-ci/python3 .
docker push registry.labs.nic.cz/turris/foris-ci/python3
