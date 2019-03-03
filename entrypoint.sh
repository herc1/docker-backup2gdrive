#!/bin/bash

touch /tmp/stdout
tail -f /tmp/stdout &
yes | cp -f /opt/conf/crontab /etc/crontab
yes | cp -f /opt/conf/ssmtp/ssmtp.conf /etc/ssmtp/

cron -f