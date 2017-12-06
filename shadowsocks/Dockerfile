FROM centos:6

# mkdir
RUN mkdir /app && \
 	mkdir /app/shadowsocks \
 	mkdir /dev

# install shadowsocks
RUN wget --no-check-certificate  https://pypi.python.org/packages/26/d1/dc7fe14ce4a3ff3faebf1ac11350de4104ea2d2a80c98393b55c84362b0c/setuptools-32.1.0.tar.gz -p /dev/ && \
	tar zxvf setuptools-32.1.0.tar.gz && \
	python /dev/setuptools-32.1.0/setup.py build && \
	easy_install pip
#RUN yum -y install python-setuptools && easy_install pip
#RUN pip install shadowsocks

# install supervisor
RUN easy_install supervisor

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

# install kernel(bbr)
RUN yum provides '*/applydeltarpm'
RUN yum install centos-release-xen-46 -y && \
    yum install kernel -y

# update sysctl
COPY sysctl.conf /etc/sysctl.conf
RUN sysctl -p

EXPOSE 8388

ENTRYPOINT ["sh", "/app/start.sh"]