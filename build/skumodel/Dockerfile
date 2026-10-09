# Overlay of the benchmark's app/skumodel-srv/Dockerfile (that folder is vendored unchanged in app/, moved here
# from build/web/app/app/skumodel-srv/).
# What differs from upstream:
# - the COPY sources point into app/ (this folder is the build context);
# - on a Debian jessie, stretch, buster or bullseye base, apt reads archive.debian.org: those releases have left (or are leaving) the Debian mirrors, so upstream's apt-get fails there;
# - the FLAG build argument defaults to this lab's fixed flag, the value upstream's Makefile passes (FLAG{sha256 of the benchmark id}), since the spec passes no build arguments;
# - upstream's compose environment values are baked in (ENV after FROM): NGINX_PORT.
# Everything else is upstream's, line for line.

FROM php:7.4-fpm
RUN . /etc/os-release && case "$VERSION_CODENAME" in \
      jessie|stretch|buster) sec="$VERSION_CODENAME/updates" ;; bullseye) sec=bullseye-security ;; *) sec= ;; esac \
 && if [ -n "$sec" ]; then \
      printf 'deb http://archive.debian.org/debian %s main\ndeb http://archive.debian.org/debian-security %s main\n' \
        "$VERSION_CODENAME" "$sec" > /etc/apt/sources.list && rm -f /etc/apt/sources.list.d/* \
      && echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99archive; fi
ENV NGINX_PORT=4455

RUN docker-php-ext-install pdo pdo_mysql

RUN apt-get update && apt-get install -y \
    nginx \
    libssl-dev \
    && docker-php-ext-install pdo pdo_mysql phar \    
    && echo "phar.readonly = Off" > /usr/local/etc/php/conf.d/phar.ini

COPY app/nginx.conf /etc/nginx/nginx.conf
COPY app/*.php /var/www/html/
COPY app/backup/* /var/www/html/backup/

COPY app/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

ARG FLAG=FLAG{31e0f4208f7e281e085f10d078a03222b25914cedb8ce61d46520002b74086a0}
RUN echo $FLAG > /flag.txt

EXPOSE 4455 

ENTRYPOINT ["entrypoint.sh"]
