FROM debian:bullseye

# Install PHP, FPM, and required extensions
RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysql \
    php-cli \
    php-curl \
    php-gd \
    php-mbstring \
    php-xml \
    php-xmlrpc \
    php-soap \
    php-intl \
    php-zip \
    curl \
    wget \
    unzip \
    mariadb-client \
    && apt-get clean

# Create working directory
WORKDIR /var/www/html

# Copy setup script
COPY tools/setup.sh /setup.sh
RUN chmod +x /setup.sh

# Expose PHP-FPM port
EXPOSE 9000

CMD ["/setup.sh"]
