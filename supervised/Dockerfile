FROM registry.nic.cz/turris/foris-ci/base:latest

RUN apt-get install -y supervisor

# start mosquitto
COPY supervisor/mosquitto.conf /etc/supervisor/conf.d/mosquitto.conf
RUN mkdir -p /run/mosquitto/ && chown mosquitto:mosquitto /run/mosquitto/

CMD ["/usr/bin/supervisord", "--nodaemon"]
