Reforis Demo
============

Usage
-----
First you need to authenticate::

    docker login registry.nic.cz


The you need to pull docker image from registry::

    docker pull registry.nic.cz/turris/foris-ci/reforis-demo

The you can run ReForis. Lets say on port 8888::

    docker run -it --rm -p 8888:80 registry.nic.cz/turris/foris-ci/reforis-demo
