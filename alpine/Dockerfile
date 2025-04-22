FROM ghcr.io/kitechsoftware/php:8.4-fpm-alpine

LABEL org.opencontainers.image.title="Laravel and Lumen Images" \
      org.opencontainers.image.description="Multi-arch images for Laravel and Lumen in Alpine and Debian" \
      org.opencontainers.image.vendor="KiTech Software" \
      org.opencontainers.image.source="https://github.com/kitechsoftware/gcr-laravel"

WORKDIR /var/www/html

# Install system dependencies and PHP extensions
RUN apk add --no-cache --virtual .build-deps \
        libpng-dev \
        libjpeg-turbo-dev \
        libwebp-dev \
        libzip-dev \
        libxml2-dev \
        sqlite-dev \
        oniguruma-dev \
        postgresql-dev \
    && apk add --no-cache \
        bash \
        curl \
        git \
        rsync \
        nginx \
        sqlite \
        postgresql-libs \
    && docker-php-ext-configure gd --with-jpeg --with-webp \
    && docker-php-ext-install -j$(nproc) \
        gd \
        pdo_mysql \
        pdo_pgsql \
        pdo_sqlite \
        mbstring \
        zip \
        opcache \
    && apk del .build-deps \
    && rm -rf /var/cache/apk/* /tmp/*

# Install Composer (with signature check)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set up runtime directories and permissions
RUN mkdir -p /run/nginx /var/lib/nginx/tmp /var/log/nginx \
    && chown -R www-data:www-data /run/nginx /var/lib/nginx /var/log/nginx /var/www/html

# Copy nginx config and setup script
COPY nginx.conf /etc/nginx/nginx.conf
COPY setup /usr/local/bin/setup

RUN chmod +x /usr/local/bin/setup

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD curl -f http://localhost || exit 1

CMD ["sh", "-c", "php-fpm & nginx -g 'daemon off;'"]
