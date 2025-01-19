FROM ghcr.io/kitechsoftware/php:8.3-fpm-debian

LABEL org.opencontainers.image.title="Laravel and Lumen Images"
LABEL org.opencontainers.image.description="Multi-arch images for Laravel and Lumen in Alpine and Debian"
LABEL org.opencontainers.image.vendor="KiTech Software"
LABEL org.opencontainers.image.source=https://github.com/kitechsoftware/gcr-laravel

WORKDIR /var/www/html

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    bash \
    nginx \
    libonig-dev \
    libzip-dev \
    libxml2-dev \
    sqlite3 \
    libsqlite3-dev \
    libpq-dev \
    && docker-php-ext-install \
        pdo_mysql \
        pdo_pgsql \
        pdo_sqlite \
        mbstring \
        zip \
        opcache \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

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
