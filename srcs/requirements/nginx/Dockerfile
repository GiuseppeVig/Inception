FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y
RUN apt-get install openssl nginx -y

RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes \
        -keyout /etc/nginx/ssl/inception.key \
        -out /etc/nginx/ssl/inception.crt \
        -subj "/C=IT/ST=Lazio/L=Rome/O=42/OU=42/CN=gvigilan.42.fr"
RUN mkdir -p /var/log/nginx/inception
RUN mkdir -p /var/run/nginx /var/www/inception
COPY ./conf/nginx.conf /etc/nginx/sites-available/nginx.conf
RUN ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/nginx.conf
RUN chmod 755 /var/www/inception
RUN chown -R www-data:www-data /var/www/inception


RUN unset MYSQL_PASSWORD MYSQL_ROOT_PASSWORD WORDPRESS_ADMIM_PASS WORDPRESS_USER_PASS

ENTRYPOINT ["nginx", "-g", "daemon off;"]