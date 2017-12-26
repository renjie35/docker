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

# install oci
# php ext oracle
RUN mkdir /download
COPY oracle/oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm /download/oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm
COPY oracle/oracle-instantclient12.2-sqlplus-12.2.0.1.0-1.x86_64.rpm /download/oracle-instantclient12.2-sqlplus-12.2.0.1.0-1.x86_64.rpm
COPY oracle/oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm /download/oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm
WORKDIR /download
RUN apt-get install alien -y \
    && alien oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm \
    && alien oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm \
    && alien oracle-instantclient12.2-sqlplus-12.2.0.1.0-1.x86_64.rpm
RUN dpkg -i oracle-instantclient12.2-basic_12.2.0.1.0-2_amd64.deb
RUN dpkg -i oracle-instantclient12.2-devel_12.2.0.1.0-2_amd64.deb
RUN dpkg -i oracle-instantclient12.2-sqlplus_12.2.0.1.0-2_amd64.deb
# load oracle env
COPY oracle/oracle.sh /etc/profile.d/oracle.sh
RUN /bin/bash -c "source /etc/profile.d/oracle.sh"
# install php ext pdo_oci oci8
RUN apt-get install libaio1
RUN C_INCLUDE_PATH=/usr/include/oracle/12.2/client64 docker-php-ext-install oci8
RUN C_INCLUDE_PATH=/usr/include/oracle/12.2/client64 docker-php-ext-install pdo_oci
RUN docker-php-ext-enable oci8 pdo_oci


# fix iconv
RUN addgroup --gid 555 --system www
RUN adduser --system --uid 555 --no-create-home --ingroup www www
RUN chmod -R 777 /run \
    && chmod -R 777 /var \
    && chmod -R 777 /usr/sbin

RUN apt-get install supervisor -y
COPY supervisord.conf /etc/supervisord.conf

# open rewrite module
RUN /usr/sbin/a2enmod rewrite

# open expires module
RUN ln -s /etc/apache2/mods-available/expires.load /etc/apache2/mods-enabled/expires.load


COPY start.sh /start.sh

EXPOSE 80 443

ENTRYPOINT ["sh","/start.sh"]