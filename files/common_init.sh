#!/bin/bash

# LOG OUTPUT TO A FILE
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>/root/.onecloud_automate/log.out 2>&1

if [[ ! -f "/root/.oncloud_automate/init.cfg" ]]
then
  # UPDATE HOSTNAME
  sed -i s/WWWWW/$( hostname | cut -d. -f1 )/g /root/.onecloud_automate/hosts
  # UPDATE FQDN
  sed -i s/XXXXX/$( hostname )/g /root/.onecloud_automate/hosts
  # UPDATE IP ADDRESS
  sed -i s/YYYYY/$( hostname -i |cut -d' ' -f1 )/g /root/.onecloud_automate/hosts
  # COPY /etc/hosts FILE
  cp /root/.onecloud_automate/hosts /etc/hosts
  touch /root/.onecloud_automate/init.cfg
fi
