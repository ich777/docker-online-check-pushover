#!/bin/bash
echo "---Trying to ping: ${HOST} every ${PING_INTERVAL} seconds with a timout of ${PING_TIMEOUT} seconds, retrying if the ping fails after ${PING_RETRY} seconds---"
while ping -c 1 -W ${PING_TIMEOUT} "${HOST}" > /dev/null
do
	echo "$(date '+%x %X'): ${HOST} is reachable"
	sleep ${PING_INTERVAL}
done
if wget https://api.pushover.net/1/messages.json --post-data="token=${PUSHOVER_APP_TOKEN}&user=${PUSHOVER_USER_TOKEN}&priority=${PUSHOVER_PRIORITY}&title=${PUSHOVER_TITLE}&message=${PUSHOVER_MESSAGE}" -qO- > /dev/null 2>&1 ; then
	echo "$(date '+%x %X'): ${HOST} not reachable!"
    echo "Pushover message sent! Retrying after ${PING_RETRY} seconds!"
	sleep ${PING_RETRY}
	echo "---------------------------------------------"
	echo "-----------------RETRYING--------------------"
	echo "---------------------------------------------"
else
	echo "Can't send message, retrying after ${PING_RETRY} seconds!"
	sleep ${PING_RETRY}
	echo "---------------------------------------------"
	echo "-----------------RETRYING--------------------"
	echo "---------------------------------------------"
fi