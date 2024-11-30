FROM php:8.3-fpm

RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    postgresql-client \
    libpq-dev && \
    docker-php-ext-install pdo pdo_pgsql pgsql

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www
COPY . .

RUN composer install --no-dev --optimize-autoloader

COPY init.sh /init.sh
RUN chmod +x /init.sh

EXPOSE 8000

CMD /init.sh
