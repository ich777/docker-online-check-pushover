#!/bin/bash
echo "-----------------------------------------------------"
echo "------Sending ping every ${PING_INTERVAL} seconds------"
echo "-------with a timeout of ${PING_TIMEOUT} seconds-------"
echo "---to: ${HOST}, if the host is not reachable---"
echo "----it will check again in ${PING_RETRY} seconds----"
echo "-----------------------------------------------------"

sleep infinity

if [ "`ping -i ${PING_INTERVAL} -W ${PING_TIMEOUT} ${HOST}`" ]; then
	echo "date %+x %+X: ${HOST} is reachable"
else
	if wget https://api.pushover.net/1/messages.json --post-data="token=${PUSHOVER_APP_TOKEN}&user=${PUSHOVER_USER_TOKEN}&priority=${PUSHOVER_PRIORITY}&title=${PUSHOVER_TITLE}&message=${PUSHOVER_MESSAGE}" -qO- > /dev/null 2>&1 & ; then
		echo "---${HOST} not reachable message sent---"
		sleep ${PING_RETRY}
	else
		echo "---Can't send message, putting server into sleep mode---"
		sleep infinity
	fi
fi