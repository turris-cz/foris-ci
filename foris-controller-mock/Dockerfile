FROM registry.nic.cz/turris/foris-ci/supervised:latest

COPY requirements.txt /requirements.txt
RUN pip install -r /requirements.txt
COPY supervisor/foris-controller.conf /etc/supervisor/conf.d/foris-controller.conf

CMD ["/usr/bin/supervisord", "--nodaemon"]
