FROM ubuntu:16.04
MAINTAINER Fluentify <devz@fluentify.com>

#Install MongoDB
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv BC711F9BA15703C6 && \
    echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list && \
    apt-get update && \
    apt-get install -y --force-yes pwgen mongodb-org mongodb-org-server mongodb-org-shell mongodb-org-mongos mongodb-org-tools && \
    echo "mongodb-org hold" | dpkg --set-selections && echo "mongodb-org-server hold" | dpkg --set-selections && \
    echo "mongodb-org-shell hold" | dpkg --set-selections && \
    echo "mongodb-org-mongos hold" | dpkg --set-selections && \
    echo "mongodb-org-tools hold" | dpkg --set-selections

VOLUME /data/db

ENV AUTH no
ENV STORAGE_ENGINE wiredTiger
ENV JOURNALING yes

ADD run.sh /run.sh
ADD set_mongodb_password.sh /set_mongodb_password.sh
RUN chmod +x /run.sh
RUN chmod +x /set_mongodb_password.sh

#Install redis
RUN apt-get install -y --force-yes redis-server
ENV HOME /var/lib/redis
ADD redis.conf /etc/redis.conf

EXPOSE 27017 28017 6379

ENTRYPOINT ["/run.sh"]
