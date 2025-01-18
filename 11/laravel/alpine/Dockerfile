FROM ghcr.io/kitechsoftware/php:8.3-fpm-alpine

WORKDIR /var/www/html

RUN apk add --no-cache \
    bash \
    curl \
    git \
    libpng-dev \
    libjpeg-turbo-dev \
    libwebp-dev \
    libzip-dev \
    libxml2-dev \
    sqlite \
    sqlite-dev \
    oniguruma-dev \
    postgresql-dev \
    && docker-php-ext-configure gd --with-jpeg --with-webp \
    && docker-php-ext-install \
        gd \
        pdo_mysql \
        pdo_pgsql \
        pdo_sqlite \
        mbstring \
        zip \
        opcache \
    && apk del --no-cache postgresql-dev sqlite-dev \
    && rm -rf /tmp/* /var/cache/apk/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY setup /usr/local/bin/setup
RUN chmod +x /usr/local/bin/setup

RUN chown -R www-data:www-data /var/www/html

USER www-data

EXPOSE 9000

CMD ["php-fpm"]

LABEL org.opencontainers.image.source https://github.com/kitechsoftware/gcr-laravel
LABEL org.opencontainers.image.title "Laravel and Lumen Images"
LABEL org.opencontainers.image.description "Multi-arch images for Laravel and Lumen in Alpine and Debian"
LABEL org.opencontainers.image.vendor "KiTech Software"