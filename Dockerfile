FROM ich777/debian-baseimage

LABEL maintainer="admin@minenet.at"

RUN apt-get update && \
	apt-get -y install --no-install-recommends iputils-ping && \
	rm -rf /var/lib/apt/lists/*

ENV HOST="google.com"
ENV PING_INTERVAL="300"
ENV PING_TIMEOUT="10"
ENV PING_RETRY="3600"
ENV PUSHOVER_APP_TOKEN=""
ENV PUSHOVER_USER_TOKEN=""
ENV PUSHOVER_TITLE="Online Check"
ENV PUSHOVER_MESSAGE="google.com is offline!"
ENV PUSHOVER_PRIORITY="0"
ENV UID=99
ENV GID=100

RUN useradd -s /bin/bash --uid $UID --gid $GID onlinecheck

ADD /scripts/ /opt/scripts/
RUN chmod -R 777 /opt/scripts/ && \
	chown -R onlinecheck /opt/scripts

USER onlinecheck

#Server Start
ENTRYPOINT ["/opt/scripts/start-server.sh"]