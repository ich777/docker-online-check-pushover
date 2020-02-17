FROM ich777/debian-baseimage

LABEL maintainer="admin@minenet.at"

RUN apt-get update && \
	apt-get -y install --no-install-recommends iputils-ping && \
	rm -rf /var/lib/apt/lists/*

ENV HOST="google.com"
ENV PING_INTERVAL="10"
ENV PING_TIMEOUT="10"
ENV PUSHOVER_APP_TOKEN=""
ENV PUSHOVER_USER_TOKEN=""
ENV PUSHOVER_TITLE="$HOST is not reachable!"
ENV PUSHOVER_MESSAGE="$HOST is reachable!"
ENV PUSHOVER_PRIORITY="0"

RUN useradd --no-create-home -s /bin/bash --uid $UID --gid $GID onlinecheck

ADD /scripts/ /opt/scripts/
RUN chmod -R 777 /opt/scripts/ && \
	chown -R onlinecheck /opt/scripts

USER onlinecheck

#Server Start
ENTRYPOINT ["/opt/scripts/start-server.sh"]