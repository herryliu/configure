#!/usr/bin/bash

. /home/pi/piRouter/setting.sh
intf=${1:-'wan'}

# shutdown the interface
sudo ${IP_CMD} link set down dev ${intf}
# change the mac address
sudo ${MACCHG} -r ${intf}
# endable the interface
sudo ${IP_CMD} link set up dev ${intf}
# reconnect the wifi
# assuming the wifi will reconnect automatically when the interface is enabled.
sleep 20
# send the notificaiton
title="`hostname`: ${intf} MAC Address change"
message="`${IP_CMD} address list`"
${PROWL} "${title}" "${message}"
