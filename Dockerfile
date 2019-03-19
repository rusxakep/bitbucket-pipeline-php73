FROM ubuntu:18.04
MAINTAINER Mikhail Baykov <mike@baikov.com>
# Cloudflare DNS
RUN echo "nameserver 1.1.1.1" | tee /etc/resolv.conf > /dev/null

# Install system packages
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        git \
        unzip \
        mcrypt \
        wget \
        curl \
        openssl \
        ssh \
        locales \
        less \
        composer \
        sudo \
        npm --no-install-recommends

# Install packages
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common --no-install-recommends && \
    DEBIAN_FRONTEND=noninteractive add-apt-repository ppa:ondrej/php -y && \
    DEBIAN_FRONTEND=noninteractive apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    php-pear
    php7.3-pgsql
    php7.3-apcu
    php7.3-http
    php7.3-igbinary
    php7.3-memcached
    php7.3-msgpack
    php7.3-opcache
    php7.3-mysql
    php7.3-zmq
    php7.3-apcu-bc
    php7.3-gd
    php7.3-ctype
    php7.3-bcmath
    php7.3-curl
    php7.3-dom
    php7.3-geoip \
    php7.3-json
    php7.3-bz2
    php7.3-gmp
    php7.3-intl
    php7.3-zip
    php7.3-xml
    php7.3-mbstring
    php7.3-pdo
    php7.3-tokenizer
    php7.3-cli
    php7.3-xdebug
    php7.3-soap \
    --no-install-recommends

RUN apt-get clean -y && \
    apt-get autoremove -y && \
    apt-get autoclean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Ensure UTF-8
RUN locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8

# Timezone & memory limit
RUN echo "date.timezone=Europe/Moscow" > /etc/php/7.3/cli/conf.d/date_timezone.ini
# Goto temporary directory.
WORKDIR /tmp
