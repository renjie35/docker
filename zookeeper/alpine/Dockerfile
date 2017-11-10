FROM java:openjdk-7u121-jre-alpine
# install exts
#RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
#    && echo "Asia/Shanghai" >  /etc/timezone \

# install zookeeper
ENV ZOOKEEPER_VERSION "3.5.2-alpha"

RUN mkdir /app && \
    mkdir /app/zookeeper

RUN wget http://mirrors.shuosc.org/apache/zookeeper/zookeeper-$ZOOKEEPER_VERSION/zookeeper-$ZOOKEEPER_VERSION.tar.gz -P /app/zookeeper
RUN tar zxvf /app/zookeeper/zookeeper*.tar.gz -C /app/zookeeper

#fix permission
RUN addgroup -g 555 -S www \
    && adduser -u 555 -D -S -G www www \
    && chmod -R 777 /run \
    && chmod -R 777 /var \
    && chmod -R 777 /usr/sbin 


COPY zoo.cfg /app/zookeeper/zookeeper-"$ZOOKEEPER_VERSION"/conf/zoo.cfg

RUN echo "/app/zookeeper/zookeeper-$"ZOOKEEPER_VERSION"/bin/zkServer.sh start" >> /app/start.sh && \
    echo "top" >> /app/start.sh

EXPOSE 2181

ENTRYPOINT ["sh", "/app/start.sh"]