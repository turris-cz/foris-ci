FROM registry.nic.cz/turris/foris-ci/supervised:latest

ENV PIP_EXTRA_INDEX_URL="https://gitlab.nic.cz/api/v4/projects/1066/packages/pypi/simple"

COPY requirements.txt /requirements.txt
RUN pip install --break-system-packages -r /requirements.txt
COPY supervisor/foris-controller.conf /etc/supervisor/conf.d/foris-controller.conf

CMD ["/usr/bin/supervisord", "--nodaemon"]
