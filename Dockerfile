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
ENV DATA_PERM=770
ENV USER="onlinecheck"

RUN useradd -s /bin/bash $USER

ADD /scripts/ /opt/scripts/
RUN chmod -R 777 /opt/scripts/

#Server Start
ENTRYPOINT ["/opt/scripts/start.sh"]