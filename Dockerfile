FROM alpine
LABEL authors="tonlie"

WORKDIR /home/nextcloud

ENV DB_USER \
    DB_PASS \
    DB_NAME \
    DB_HOST \
    FTP_USER \
    FTP_PASS \
    FTP_HOST \

RUN apk add rclone mysql-client

ENTRYPOINT ["entrypoint.sh"]