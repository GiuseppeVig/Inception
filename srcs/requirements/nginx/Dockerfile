FROM debian:bullseye

RUN apt-get update
RUN apt-get install -y nginx openssl

COPY conf/nginx.conf /etc/nginx/sites-enabled/nginx.conf
COPY tools/nginx_start.sh /var/www

RUN chmod +x /var/www/nginx_start.sh && /var/www/nginx_start.sh

EXPOSE 443

ENTRYPOINT [ "var/www/nginx_start.sh" ]

CMD ["nginx", "-g", "daemon off;"]
