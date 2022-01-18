FROM php:8.0-apache

RUN apt-get update && apt-get install -y

RUN docker-php-ext-install mysqli pdo_mysql

RUN mkdir /app \
 && mkdir /app/hemia-demo \
 && mkdir /app/hemia-demo/test

COPY ./ /app/hemia-mysql-demo/test

RUN cp -r /app/hemia-mysql-demo/test/* /var/www/html/.



