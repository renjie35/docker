FROM php:7-apache
# install php exts
RUN apk update \
    && apk add openssh \
    && apk add git \
    && apk add --no-cache --virtual .phpdeps \
        $PHPIZE_DEPS openssl-dev pcre-dev libpng-dev freetype-dev libjpeg-turbo-dev libpng-dev libxml2-dev tzdata \
    && apk add --no-cache libmcrypt-dev \
    && pecl channel-update pecl.php.net \
    && pecl install mongodb \
    && pecl install redis \
    && docker-php-ext-install opcache bcmath exif mcrypt mysqli pdo_mysql shmop soap sockets sysvsem xmlrpc zip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-png-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-enable opcache bcmath exif gd mcrypt mysqli pdo_mysql shmop soap sockets sysvsem xmlrpc zip mongodb redis \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" >  /etc/timezone \

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