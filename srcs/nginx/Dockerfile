FROM alpine:3.19

# Install MariaDB
RUN apk update && apk add --no-cache mariadb mariadb-client

# Copy setup script
COPY tools/setup.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# Create run dir
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

# Expose port (for completeness)
EXPOSE 3306

# Start MariaDB correctly
CMD ["/docker-entrypoint.sh"]
