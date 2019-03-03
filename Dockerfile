FROM ubuntu:18.04

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get -y update 

RUN apt-get -y upgrade

RUN apt-get -y install tar zip cron mysql-client ssmtp mpack

RUN mkdir /opt/conf

RUN mkdir /opt/backup

COPY crontab /etc/

COPY entrypoint.sh /

COPY backup2mail /

ENTRYPOINT ["/entrypoint.sh"]