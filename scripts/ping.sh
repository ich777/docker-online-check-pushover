#!/bin/bash
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
	/opt/scripts/./$(basename $0) && exit
else
	echo "Can't send message, retrying after ${PING_RETRY} seconds!"
	sleep ${PING_RETRY}
	echo "---------------------------------------------"
	echo "-----------------RETRYING--------------------"
	echo "---------------------------------------------"
	/opt/scripts/./$(basename $0) && exit
fi