#!/bin/sh

# Define domain
DOMAIN=${DOMAIN_NAME:-localhost}

# Create certs folder
mkdir -p /etc/nginx/certs

# Generate a self-signed cert
openssl req -x509 -nodes -days 365 \
  -newkey rsa:2048 \
  -keyout /etc/nginx/certs/${DOMAIN}.key \
  -out /etc/nginx/certs/${DOMAIN}.crt \
  -subj "/C=FR/ST=42/L=Intra/O=School/CN=${DOMAIN}"
