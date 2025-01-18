FROM ghcr.io/kitechsoftware/php:8.3-fpm-alpine

WORKDIR /var/www/html

RUN apk add --no-cache \
    bash \
    curl \
    git \
    nginx \
    libpng-dev \
    libjpeg-turbo-dev \
    libwebp-dev \
    libzip-dev \
    libxml2-dev \
    sqlite \
    sqlite-dev \
    oniguruma-dev \
    postgresql-dev \
    postgresql-libs \
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

# Ensure required Nginx directories exist and set correct permissions
RUN mkdir -p /var/lib/nginx/tmp /var/log/nginx /run/nginx \
    && chown -R www-data:www-data /var/lib/nginx /var/log/nginx /run/nginx

# Copy Nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

COPY setup /usr/local/bin/setup
RUN chmod +x /usr/local/bin/setup

# Adjust PHP-FPM configuration
RUN sed -i 's/^user = .*/;user = www-data/' /usr/local/etc/php-fpm.d/www.conf \
    && sed -i 's/^group = .*/;group = www-data/' /usr/local/etc/php-fpm.d/www.conf

RUN chown -R www-data:www-data /var/www/html

EXPOSE 80

CMD ["sh", "-c", "php-fpm & nginx -g 'daemon off;'"]

LABEL org.opencontainers.image.source=https://github.com/kitechsoftware/gcr-laravel
LABEL org.opencontainers.image.title="Laravel and Lumen Images"
LABEL org.opencontainers.image.description="Multi-arch images for Laravel and Lumen in Alpine and Debian"
LABEL org.opencontainers.image.vendor="KiTech Software"