FROM ich777/debian-baseimage

LABEL maintainer="admin@minenet.at"

RUN apt-get update && \
	apt-get -y install --no-install-recommends iputils-ping && \
	rm -rf /var/lib/apt/lists/*

ENV DATA_DIR="/serverdata"
ENV HOST="google.com"
ENV PING_INTERVAL="10"
ENV PING_TIMEOUT="10"
ENV PUSHOVER_APP_TOKEN=""
ENV PUSHOVER_USER_TOKEN=""
ENV PUSHOVER_TITLE="$HOST is offline!"
ENV PUSHOVER_MESSAGE="$HOST is offline!"
ENV PUSHOVER_PRIORITY="0"
ENV UMASK=000
ENV UID=99
ENV GID=100

RUN mkdir $DATA_DIR && \
	useradd -d $DATA_DIR -s /bin/bash --uid $UID --gid $GID onlinecheck && \
	chown -R onlinecheck $DATA_DIR && \
	ulimit -n 2048

ADD /scripts/ /opt/scripts/
RUN chmod -R 777 /opt/scripts/ && \
	chown -R onlinecheck /opt/scripts

USER onlinecheck

#Server Start
ENTRYPOINT ["/opt/scripts/start-server.sh"]