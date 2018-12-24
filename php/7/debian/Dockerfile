FROM php:7-apache
# install php exts
RUN apt-get update \
    && apt-get install openssl -y  \
    && apt-get install libssl-dev -y \
    && pecl install redis \
    && apt-get install libxml2-dev -y \
    && apt-get install zlib1g-dev libzip-dev -y \
    && docker-php-ext-install soap zip \

    && docker-php-ext-install opcache bcmath exif mysqli pdo_mysql shmop sockets sysvsem xmlrpc \

    && apt-get install libjpeg-dev libpng-dev libfreetype6-dev -y \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-png-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \

    && docker-php-ext-enable opcache bcmath exif mysqli pdo_mysql shmop sockets sysvsem xmlrpc soap zip redis gd\
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" >  /etc/timezone

# fix iconv
#RUN groupadd --gid 555 --system www
#RUN useradd --system --uid 555 -g www www
RUN chmod -R 777 /run \
    && chmod -R 777 /var \
    && chmod -R 777 /usr/sbin 
RUN useradd www -g www-data

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