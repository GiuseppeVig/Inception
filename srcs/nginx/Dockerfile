FROM alpine:3.19

# Install MariaDB
RUN apk update && apk add --no-cache nginx openssl

# Copy setup script
COPY tools/generate_cert.sh /generate_cert.sh
COPY conf/nginx.conf /etc/nginx/nginx.conf
RUN chmod +x /generate_cert.sh && /generate_cert.sh

# Create run dir
RUN mkdir -p /run/nginx

# Expose port (for completeness)
EXPOSE 443

# Start MariaDB correctly
CMD ["nginx", "-g", "daemon off;"]
