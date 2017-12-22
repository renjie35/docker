FROM php:5.6-apache
# install php exts
RUN apt-get update \
    && apt-get install libssl-dev -y \
    && pecl install mongodb \
    && pecl install redis \

    && apt-get install libmcrypt-dev -y \
    && apt-get install libxml2-dev \
    && docker-php-ext-install mcrypt soap zip \

    && docker-php-ext-install opcache bcmath exif mysqli pdo_mysql shmop sockets sysvsem xmlrpc \

    && apt-get install libjpeg-dev -y \
    && apt-get install libpng-dev -y \
    && apt-get install libfreetype6-dev -y \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-png-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \

    && docker-php-ext-enable opcache bcmath exif mysqli pdo_mysql shmop sockets sysvsem xmlrpc mcrypt soap zip mongodb redis gd\
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" >  /etc/timezone

# fix iconv
RUN addgroup --gid 555 --system www
RUN adduser --system --uid 555 --no-create-home --ingroup www www
RUN chmod -R 777 /run \
    && chmod -R 777 /var \
    && chmod -R 777 /usr/sbin

RUN apt-get install supervisor -y
COPY supervisord.conf /etc/supervisord.conf

COPY start.sh /start.sh

EXPOSE 80 443

ENTRYPOINT ["sh","/start.sh"]

# open rewrite module
RUN ﻿a2enmod rewrite