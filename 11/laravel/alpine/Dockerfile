FROM ghcr.io/kitechsoftware/php:8.3-fpm-alpine

LABEL org.opencontainers.image.title="Laravel and Lumen Images"
LABEL org.opencontainers.image.description="Multi-arch images for Laravel and Lumen in Alpine and Debian"
LABEL org.opencontainers.image.vendor="KiTech Software"
LABEL org.opencontainers.image.source=https://github.com/kitechsoftware/gcr-laravel

WORKDIR /var/www/html

# Install dependencies and PHP extensions
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

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Ensure required directories exist and set correct permissions
RUN mkdir -p /run/nginx /var/lib/nginx/tmp /var/log/nginx \
    && chown -R www-data:www-data /var/lib/nginx /var/log/nginx /run/nginx /var/www/html

# Copy Nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Copy post-setup script
COPY setup /usr/local/bin/setup
RUN chmod +x /usr/local/bin/setup

# Expose the port for Nginx
EXPOSE 80

# Run Nginx and PHP-FPM together
CMD ["sh", "-c", "php-fpm & nginx -g 'daemon off;'"]
