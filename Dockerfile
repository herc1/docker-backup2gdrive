FROM ubuntu:18.04

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get -y update 

RUN apt-get -y upgrade

RUN apt-get -y install tar zip cron mysql-client wget

RUN wget "https://docs.google.com/uc?id=0B3X9GlR6EmbnQ0FtZmJJUXEyRTA&export=download" -O /usr/bin/gdrive

RUN chmod +x /usr/bin/gdrive

RUN echo "@reboot /usr/bin/gdrive about" >> /etc/crontab

ENTRYPOINT ["/usr/sbin/cron", "-f"]