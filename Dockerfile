FROM ubuntu:18.04

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get -y update 

RUN apt-get -y upgrade

RUN apt-get -y install tar zip cron mysql-client ssmtp

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]