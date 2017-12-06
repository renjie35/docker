# debian
FROM debian:9.2

# mkdir
RUN mkdir /app

# install shadowsocks
RUN apt-get update &&\
	apt-get install python-pip -y &&\
	pip install shadowsocks
#RUN yum -y install python-setuptools && easy_install pip
#RUN pip install shadowsocks

# install supervisor
RUN apt-get install supervisor -y
#RUN easy_install supervisor

# set conf
COPY shadowsocks.json /etc/shadowsocks.json
COPY supervisord.conf /etc/supervisord.conf
COPY supervisor/shadowsocks.ini /supervisor/shadowsocks.

# fix permission
RUN chmod 755 /etc/shadowsocks.json

RUN echo "supervisord -c /etc/supervisord.conf" >> /app/start.sh && \
	echo "top" >> /app/start.sh

RUN echo "* soft nofile 51200" >> /etc/security/limits.conf && \
	echo "* hard nofile 51200" >> /etc/security/limits.conf

RUN ulimit -n 51200

# install kernel
RUN echo "deb http://ftp.debian.org/debian jessie-backports main" >> /etc/apt/sources.list
RUN apt-get install -t jessie-backports linux-image-amd64 -y
#RUN yum install centos-release-xen-46 -y && \
#    yum install kernel -y

# update sysctl
COPY sysctl.conf /etc/sysctl.conf
RUN sysctl -p

EXPOSE 8388

ENTRYPOINT ["sh", "/app/start.sh"]