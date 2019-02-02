#!/bin/bash

touch /tmp/stdout
tail -f /tmp/stdout &
gdrive about > /tmp/stdout
yes | cp -f /opt/backup/crontab /etc/crontab
cron -f &
while true; do
 if [ $(pgrep cron | wc -l) -eq 0 ]
 then
  echo "cron is not running! Starting"
  cron -f &
 fi
 sleep 5
done