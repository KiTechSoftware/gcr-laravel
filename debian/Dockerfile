FROM ghcr.io/kitechsoftware/php:8.4-fpm-debian

LABEL org.opencontainers.image.title="Laravel and Lumen Images" \
      org.opencontainers.image.description="Multi-arch images for Laravel and Lumen in Alpine and Debian" \
      org.opencontainers.image.vendor="KiTech Software" \
      org.opencontainers.image.source="https://github.com/kitechsoftware/gcr-laravel"

WORKDIR /var/www/html

# Install dependencies and PHP extensions
RUN apt-get update && apt-get install -y --no-install-recommends \
      git \
      bash \
      nginx \
      rsync \
      curl \
      libonig-dev \
      libzip-dev \
      libxml2-dev \
      sqlite3 \
      libsqlite3-dev \
      libpq-dev \
  && docker-php-ext-install -j"$(nproc)" \
      pdo_mysql \
      pdo_pgsql \
      pdo_sqlite \
      mbstring \
      zip \
      opcache \
  && apt-get purge -y --auto-remove \
      libonig-dev \
      libzip-dev \
      libxml2-dev \
      libsqlite3-dev \
      libpq-dev \
  && rm -rf /var/lib/apt/lists/* /tmp/*

# Install Composer (with hash check optional)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Create required directories and set permissions
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
