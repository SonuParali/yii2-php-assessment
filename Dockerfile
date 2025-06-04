FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
    unzip git libzip-dev zip curl\
    && docker-php-ext-install pdo pdo_mysql zip

RUN a2enmod rewrite

COPY ./yii2 /var/www/html/

WORKDIR /var/www/html

RUN sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html|' /etc/apache2/sites-available/000-default.conf

RUN sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

HEALTHCHECK --interval=15s --timeout=5s --start-period=15s --retries=3 \
    CMD curl -f http://localhost/ || exit 1