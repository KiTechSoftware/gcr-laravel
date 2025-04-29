FROM ghcr.io/kitechsoftware/php:latest

LABEL org.opencontainers.image.title="Laravel and Lumen Images" \
      org.opencontainers.image.description="Multi-arch images for Laravel and Lumen in Alpine and Debian" \
      org.opencontainers.image.vendor="KiTech Software" \
      org.opencontainers.image.source="https://github.com/kitechsoftware/gcr-laravel"

# Install dependencies and PHP extensions
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
  && apt-get update && apt-get install -y --no-install-recommends \
  git nginx rsync sqlite3 nodejs \
  && apt-get purge -y --auto-remove \
  && rm -rf /var/lib/apt/lists/* /tmp/*

# Create required directories and set permissions
RUN mkdir -p /run/nginx /var/lib/nginx/tmp /var/log/nginx \
  && chown -R www-data:www-data /run/nginx /var/lib/nginx /var/log/nginx /var/www/html

# Copy nginx config and setup script
COPY nginx.conf /etc/nginx/nginx.conf
COPY setup /usr/local/bin/setup
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /usr/local/bin/setup /entrypoint.sh

WORKDIR /app

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD curl -f http://localhost || exit 1

CMD ["/entrypoint.sh"]
