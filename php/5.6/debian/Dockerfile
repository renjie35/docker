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


# php ext oracle
RUN mkdir /download
COPY oracle/ /download/
# install php ext pdo_oci oci8
ENV ORACLE_HOME=/usr/lib/oracle/11.2/client64 LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ORACLE_HOME/lib PATH=$PATH:$ORACLE_HOME/bin TNS_ADMIN=$ORACLE_HOME/network/admin NLS_LANG="SIMPLIFIED CHINESE_CHINA.ZHS16GBK"
WORKDIR /download
RUN dpkg -i oracle-instantclient11.2-basic_11.2.0.4.0-2_amd64.deb \
    && dpkg -i oracle-instantclient11.2-devel_11.2.0.4.0-2_amd64.deb \
    && dpkg -i oracle-instantclient11.2-sqlplus_11.2.0.4.0-2_amd64.deb \
    && mkdir $ORACLE_HOME/network \
    && mkdir $ORACLE_HOME/network/admin \
    && apt-get install libaio1 \
    && C_INCLUDE_PATH=/usr/include/oracle/11.2/client64 docker-php-ext-install oci8 \
    && C_INCLUDE_PATH=/usr/include/oracle/11.2/client64 docker-php-ext-install pdo_oci \
    && docker-php-ext-enable oci8 pdo_oci \
    && rm -rf /download

# fix iconv
RUN addgroup --gid 555 --system www
RUN adduser --system --uid 555 --no-create-home --ingroup www www
RUN chmod -R 777 /run \
    && chmod -R 777 /var \
    && chmod -R 777 /usr/sbin

# install supervisor cron vim git
RUN apt-get install supervisor -y \
    && apt-get install cron -y \
    && apt-get install vim -y \
    && apt-get install git -y
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