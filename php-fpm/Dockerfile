FROM php:7.2-fpm

RUN  mkdir -p /var/cache

RUN docker-php-ext-install pdo pdo_mysql bcmath opcache

RUN apt-get update && \
    apt-get install -y --no-install-recommends git zip unzip wget gettext build-essential zlib1g-dev \
    automake \
    cmake \
    g++ \
    librabbitmq-dev \
    libreadline-dev \
    pkg-config

RUN curl -sS https://getcomposer.org/installer | \
    php -- --install-dir=/usr/bin/ --filename=composer

RUN docker-php-ext-install mysqli

#####################################
# xDebug:
#####################################
# XDEBUG: https://gist.github.com/chadrien/c90927ec2d160ffea9c4
# https://gist.github.com/chadrien/c90927ec2d160ffea9c4#gistcomment-1881975
ARG PHP_XDEBUG_ENABLED
RUN if [ ${PHP_XDEBUG_ENABLED:-false} = "true" ] ; then \
    # Install the xdebug extension
    echo "XDebug enabled\n" \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
#    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.default_enable       = 0"                       >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_autostart     = 0"                       >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_connect_back  = 0"                       >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.profiler_enable      = 0"                       >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_handler       = dbgp"                    >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.profiler_output_dir  = /var/log/php-fpm"        >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_log           = /app/var/log/xdebug.log" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
else \
    echo "XDebug disabled\n" \
;fi