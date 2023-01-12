FROM shinsenter/php:8.2-fpm-apache
RUN echo 'error_log = /var/log/php_error_log' >> /etc/php/8.2/fpm/php.ini \
    && echo 'ignore_repeated_errors = on' >> /etc/php/8.2/fpm/php.ini \
    && sed -i 's/80/8080/g' /etc/apache2/sites-available/000-default.conf /etc/apache2/ports.conf \
    && echo "ServerSignature Off" >> /etc/apache2/apache2.conf 

COPY . /var/www/html

EXPOSE 8080