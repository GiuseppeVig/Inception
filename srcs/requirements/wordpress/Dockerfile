FROM debian:bullseye

# Install system dependencies and Sury PHP repository
RUN apt-get update && apt-get install -y \
    curl \
    lsb-release \
    apt-transport-https \
    ca-certificates \
    gnupg2

# Add Sury PHP repo
RUN curl -fsSL https://packages.sury.org/php/apt.gpg | gpg --dearmor -o /usr/share/keyrings/sury.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/sury.gpg] https://packages.sury.org/php $(lsb_release -sc) main" \
    > /etc/apt/sources.list.d/php.list

# Install PHP 7.3, extensions, and mariadb client
RUN apt-get update && apt-get install -y \
    php7.3-fpm \
    php7.3-mysqli \
    mariadb-client

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Copy custom PHP-FPM pool configuration
COPY conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

# Ensure PHP run dir exists with correct permissions
RUN mkdir -p /run/php && chmod 755 /run/php

# Add WordPress startup script
COPY tools/setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

# Set working directory
WORKDIR /var/www/html

# Expose PHP-FPM port
EXPOSE 9000

# Set entrypoint to your custom script
ENTRYPOINT ["/usr/local/bin/setup.sh"]
