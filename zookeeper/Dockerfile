FROM centos:7.4.1708
ENV NGINX_VERSION 1.12.0
# install java
RUN yum install -y java
#fix permission
RUN groupadd -g 555 -r www \
    && adduser -u 555 -r -g www www \
    && chmod -R 777 /run \
    && chmod -R 777 /var \
    && chmod -R 777 /usr/sbin 