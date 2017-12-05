FROM centos:7.4.1708
# install python-setuptools && easy_install pip
RUN yum -y install python-setuptools && easy_install pip
# install git
RUN yum -y install git
# download shadowsocks
RUN pip install git+https://github.com/shadowsocks/shadowsocks.git@master

RUN mkdir /app && \
 	mkdir /app/shadowsocks

# set conf
COPY shadowsocks.json /etc/shadowsocks.json

# fix permission
RUN chmod 755 /etc/shadowsocks.json


RUN echo "ssserver -c /etc/shadowsocks.json -d start" >> /app/start.sh && \
RUN	echo "top" >> /app/start.sh

EXPOSE 1014

ENTRYPOINT ["sh", "/app/start.sh"]