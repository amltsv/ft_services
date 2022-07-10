FROM alpine:3.12

RUN apk update && apk add nginx curl openssl libressl supervisor
COPY nginx.conf		/etc/nginx
COPY index.html		var/www/
RUN mkdir -p run/nginx

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj '/C=RU/L=Moscow/O=21sch/CN=ssl_certif'

RUN curl 'https://dl.influxdata.com/telegraf/releases/telegraf-1.18.0_linux_i386.tar.gz' > telegraf.tar.gz && \
    tar xvf telegraf.tar.gz && mv 'telegraf-1.18.0' telegraf && rm telegraf.tar.gz

COPY telegraf.conf /etc/telegraf/telegraf.conf

COPY supervisord.conf .

EXPOSE 80
EXPOSE 443

CMD ["supervisord", "-c", "supervisord.conf"]