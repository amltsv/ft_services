
FROM alpine:3.12

RUN apk update \
&& apk add mariadb mariadb-client curl supervisor && apk add --no-cache --upgrade bash \
&& rm -rf /var/cache/apk/*

COPY mysql_init.sh .
COPY mysql_start.sh .
COPY wordpress.sql .
COPY supervisord.conf .

RUN chmod 777 mysql_init.sh
RUN chmod 777 mysql_start.sh

RUN curl 'https://dl.influxdata.com/telegraf/releases/telegraf-1.18.0_linux_i386.tar.gz' > telegraf.tar.gz && \
    tar xvf telegraf.tar.gz && mv 'telegraf-1.18.0' telegraf

COPY telegraf.conf /etc/telegraf/telegraf.conf

EXPOSE 3306

CMD ["supervisord", "-c", "supervisord.conf"]

