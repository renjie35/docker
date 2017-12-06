# ubuntu
FROM ubuntu:16.04

# mkdir
RUN mkdir /app

# install shadowsocks
RUN apt-get update &&\
	apt-get install python-pip -y &&\
	pip install shadowsocks
#RUN yum -y install python-setuptools && easy_install pip &&\
#	pip install shadowsocks

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

EXPOSE 8080

ENTRYPOINT ["sh", "/app/start.sh"]