FROM alpine:latest
LABEL authors="tonlie"

ADD "entrypoint.sh" "/"
RUN chmod +x "/entrypoint.sh"

WORKDIR /home/nextcloud

ENV DB_USER \
    DB_PASS \
    DB_NAME \
    DB_HOST \
    FTP_USER \
    FTP_PASS \
    FTP_HOST

RUN apk add rclone mysql-client

ENTRYPOINT ["/entrypoint.sh"]