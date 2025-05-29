FROM alpine:3.19

RUN apk update && apk add mariadb mariadb-client

COPY setup.sh /setup.sh
RUN chmod +x /setup.sh

CMD ["sh", "/setup.sh"]
