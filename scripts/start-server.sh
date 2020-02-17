#!/bin/bash
echo "---Trying to ping: ${HOST} every ${PING_INTERVAL} seconds with a timout of ${PING_TIMEOUT}, retrying if the ping fails after ${PING_RETRY}---"
/opt/scripts/ping.sh