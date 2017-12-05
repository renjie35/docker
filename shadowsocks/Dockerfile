FROM centos:7.4.1708
# install python-setuptools && easy_install pip
RUN yum -y install python-setuptools && easy_install pip
# install supervisor
RUN easy_install supervisor
# install git
RUN yum -y install git
# download shadowsocks
RUN pip install git+https://github.com/shadowsocks/shadowsocks.git@master

RUN mkdir /app && \
 	mkdir /app/shadowsocks && \
 	mkdir /supervisor

# set conf
COPY shadowsocks.json /etc/shadowsocks.json
COPY supervisord.conf /etc/supervisord.conf
COPY supervisord/shadowsocks.ini /supervisor/shadowsocks.ini

# fix permission
RUN chmod 755 /etc/shadowsocks.json

RUN echo "supervisorctl -c /etc/supervisord.conf" >> /app/start.sh && \
	echo "top" >> /app/start.sh

EXPOSE 8388

ENTRYPOINT ["sh", "/app/start.sh"]