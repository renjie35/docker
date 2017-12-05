FROM centos:7.4.1708
# install wget java
# RUN yum -y install wget java
# install zookeeper
# ENV ZOOKEEPER_VERSION "3.5.2-alpha"

# RUN mkdir /app && \
# 	mkdir /app/zookeeper

#RUN wget http://mirrors.shuosc.org/apache/zookeeper/zookeeper-$ZOOKEEPER_VERSION/zookeeper-$ZOOKEEPER_VERSION.tar.gz -P /app/zookeeper
#RUN tar zxvf /app/zookeeper/zookeeper*.tar.gz -C /app/zookeeper

#fix permission
#RUN groupadd -g 555 -r www \
#    && adduser -u 555 -r -g www www \
#    && chmod -R 777 /run \
#    && chmod -R 777 /var \
#    && chmod -R 777 /usr/sbin 


#COPY zoo.cfg /app/zookeeper/zookeeper-"$ZOOKEEPER_VERSION"/conf/zoo.cfg

#RUN echo "/app/zookeeper/zookeeper-$"ZOOKEEPER_VERSION"/bin/zkServer.sh start" >> /app/start.sh && \
RUN	echo "top" >> /app/start.sh

#EXPOSE 2181

ENTRYPOINT ["sh", "/app/start.sh"]