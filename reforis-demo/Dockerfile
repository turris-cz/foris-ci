FROM node:16-bullseye AS node

RUN apt-get update && apt-get install -y python3-pip python3-wheel git webpack

COPY requirements-reforis.txt /requirements-reforis.txt
RUN pip -v wheel --no-deps -r /requirements-reforis.txt

COPY requirements-reforis-plugins.txt /requirements-reforis-plugins.txt
RUN \
	mkdir /plugins/ && \
	cd plugins && \
	pip -v wheel --no-deps -r /requirements-reforis-plugins.txt

FROM registry.nic.cz/turris/foris-ci/foris-controller-mock:latest

COPY requirements-foris-ws.txt /requirements-foris-ws.txt
COPY --from=node /reforis*.whl /
RUN mkdir /plugins/
COPY --from=node /plugins/*.whl /plugins/

RUN pip -v install -r /requirements-foris-ws.txt
RUN pip install /plugins/*.whl
RUN pip install /reforis*.whl

RUN apt-get update && apt-get install -y nginx

COPY supervisor/nginx.conf /etc/supervisor/conf.d/nginx.conf
COPY supervisor/reforis.conf /etc/supervisor/conf.d/reforis.conf
COPY supervisor/foris-ws.conf /etc/supervisor/conf.d/foris-ws.conf
COPY demo.py /usr/local/lib/python3.9/dist-packages/reforis/config/demo.py
COPY __main__.py /usr/local/lib/python3.9/dist-packages/reforis/__main__.py
COPY nginx/default.conf /etc/nginx/sites-available/default

CMD ["/usr/bin/supervisord", "--nodaemon"]
