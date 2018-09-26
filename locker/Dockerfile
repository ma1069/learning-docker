# Learning Locker (http://learninglocker.net/) LRS container
# Based on http://docs.learninglocker.net/guides-custom-installation/
# Version 2

# Pull and use the centos7 image as the base
FROM centos:centos7
USER root

MAINTAINER Fluentify devz@fluentify.com

# Update image
RUN yum update -y

# Install Remi Collet Repository
RUN yum install -y epel-release
RUN rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm

# Install stuff
RUN yum install -y --enablerepo=remi curl git python make automake gcc gcc-c++ kernel-devel xorg-x11-server-Xvfb git-core npm nodejs nginx

# Install Bower
RUN npm install -g yarn
RUN npm install -g pm2
RUN pm2 install pm2-logrotate
RUN pm2 set pm2-logrotate:compress true

# install learninglocker
RUN git clone https://github.com/LearningLocker/learninglocker.git /learninglocker
ADD ./conf/llocker.env /learninglocker/.env
RUN cd /learninglocker; yarn install; 
RUN cd /learninglocker; yarn build-all

# install xAPI
RUN git clone https://github.com/LearningLocker/xapi-service.git /xapi
ADD ./conf/xapi.env /xapi/.env
RUN cd /xapi; yarn install --ignore-engines
RUN cd /xapi; yarn build

# add local configurations
ADD ./conf/nginx.conf /etc/nginx.conf

# create our container startup script
ADD run.sh /usr/bin/run.sh
RUN chmod +x /usr/bin/run.sh

EXPOSE 3001 3000

# define entrypoint so ll will start from docker run
ENTRYPOINT ["/usr/bin/run.sh"]
