#!/bin/bash
echo "-----------------------------------------------------"
echo "------Sending ping every ${PING_INTERVAL} seconds------"
echo "-------with a timeout of ${PING_TIMEOUT} seconds-------"
echo "---to: ${HOST}, if the host is not reachable---"
echo "----it will check again in ${PING_RETRY} seconds----"
echo "-----------------------------------------------------"

while ping -c 1 -W ${PING_TIMEOUT} "${HOST}" > /dev/null
do
        echo "$(date '+%x %X'): ${HOST} is reachable"
        sleep ${PING_INTERVAL}
done
if wget https://api.pushover.net/1/messages.json --post-data="token=${PUSHOVER_APP_TOKEN}&user=${PUSHOVER_USER_TOKEN}&priority=${PUSHOVER_PRIORITY}&title=${PUSHOVER_TITLE}&message=${PUSHOVER_MESSAGE}" -qO- > /dev/null 2>&1 ; then
        echo "---$(date '+%x %X'): ${HOST} not reachable message sent, retrying after ${PING_RETRY} seconds!---"
        sleep ${PING_RETRY}
        /opt/scripts/./$(basename $0) && exit
else
        echo "---Can't send message, retrying after ${PING_RETRY} seconds---"
        sleep ${PING_RETRY}
        /opt/scripts/./$(basename $0) && exit
fi