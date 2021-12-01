#!/bin/bash

docker login registry.nic.cz

# Build all docker files
docker build -t registry.nic.cz/turris/foris-ci/base -f base/Dockerfile base
# registry.nic.cz/turris/foris-ci/python3 is kept there for comaptibility reasons
docker build -t registry.nic.cz/turris/foris-ci/python3 -t registry.nic.cz/turris/foris-ci/ci-tests -f ci-tests/Dockerfile ci-tests
docker build -t registry.nic.cz/turris/foris-ci/supervised -f supervised/Dockerfile supervised
docker build -t registry.nic.cz/turris/foris-ci/foris-controller-mock -f foris-controller-mock/Dockerfile foris-controller-mock
docker build -t registry.nic.cz/turris/foris-ci/reforis-demo -f reforis-demo/Dockerfile reforis-demo

# Push it to the registry
docker push registry.nic.cz/turris/foris-ci/base
docker push registry.nic.cz/turris/foris-ci/python3
docker push registry.nic.cz/turris/foris-ci/ci-tests
docker push registry.nic.cz/turris/foris-ci/supervised
docker push registry.nic.cz/turris/foris-ci/foris-controller-mock
docker push registry.nic.cz/turris/foris-ci/reforis-demo
