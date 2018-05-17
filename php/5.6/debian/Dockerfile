FROM php:5.4.41-apache
# install php exts
RUN apt-get update \
    && apt-get install libssl-dev -y \
    && pecl install mongodb \
    && pecl install redis \

    && apt-get install libmcrypt-dev libxml2-dev -y \
    && docker-php-ext-install mcrypt soap zip \

    && docker-php-ext-install opcache bcmath exif mysqli pdo_mysql shmop sockets sysvsem xmlrpc \

    && apt-get install libjpeg-dev libpng-dev libfreetype6-dev -y \
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

# install supervisor cron vim git
RUN apt-get install supervisor cron vim git -y
COPY supervisord.conf /etc/supervisord.conf

# open apache rewrite expires module
RUN /usr/sbin/a2enmod rewrite \
    && ln -s /etc/apache2/mods-available/expires.load /etc/apache2/mods-enabled/expires.load

COPY start.sh /start.sh

# clean apt-get
RUN apt-get autoremove \
    && apt-get clean

EXPOSE 80 443
WORKDIR /var/www/html

ENTRYPOINT ["sh","/start.sh"]