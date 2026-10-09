# Overlay of the benchmark's app/Dockerfile (the benchmark is vendored unchanged in app/, except app/skumodel-srv/,
# moved to build/skumodel/app/ for the skumodel machine's overlay).
# What differs from upstream:
# - the COPY sources point into app/app/ (this folder is the build context), so the web root no longer carries a
#   copy of skumodel-srv/ (upstream's COPY . took it along only because it sits in the same folder; it runs on
#   the skumodel machine);
# - on a Debian jessie, stretch, buster or bullseye base, apt reads archive.debian.org: those releases have left (or are leaving) the Debian mirrors, so upstream's apt-get fails there.
# Everything else is upstream's, line for line.

FROM php:8.0-apache
RUN . /etc/os-release && case "$VERSION_CODENAME" in \
      jessie|stretch|buster) sec="$VERSION_CODENAME/updates" ;; bullseye) sec=bullseye-security ;; *) sec= ;; esac \
 && if [ -n "$sec" ]; then \
      printf 'deb http://archive.debian.org/debian %s main\ndeb http://archive.debian.org/debian-security %s main\n' \
        "$VERSION_CODENAME" "$sec" > /etc/apt/sources.list && rm -f /etc/apt/sources.list.d/* \
      && echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99archive; fi

WORKDIR /var/www/html

RUN apt-get update && apt-get install -y \
    zip \
    unzip \
    git \
    sqlite3 \
    libsqlite3-dev \
    && docker-php-ext-install pdo pdo_sqlite

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY app/app/ /var/www/html
COPY app/app/composer.json /var/www/html/composer.json

COPY app/app/wwwconf/ports.conf /etc/apache2/ports.conf
COPY app/app/wwwconf/000-default.conf /etc/apache2/sites-available/000-default.conf

RUN groupadd -g 1000 appuser && \
    useradd -u 1000 -g appuser -m appuser

RUN chown -R appuser:appuser /var/www/html

    RUN mkdir -p /var/db && \
    chown -R www-data:www-data /var/db

USER appuser
RUN composer install 

USER root
RUN chown -R www-data:www-data /var/www/html/vendor

EXPOSE 8081

CMD ["apache2-foreground"]
