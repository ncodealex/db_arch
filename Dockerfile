FROM php:8.3-cli-alpine3.21

COPY --from=ghcr.io/mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/install-php-extensions
COPY --from=ghcr.io/roadrunner-server/roadrunner:2024.1.5 /usr/bin/rr /usr/local/bin/rr
COPY --from=composer:2.8.4 /usr/bin/composer /usr/bin/composer

#RUN apt-get update && apt-get install -y \
#    libpq-dev \
#    libzip-dev \
#    unzip \
#    nano \
#    autoconf \
#    zlib1g-dev

RUN apk update && apk add --no-cache \
  bash \
  nano \
  autoconf \
  ca-certificates \
  icu-data-full icu-libs \
  libgpg-error libgcrypt libxslt \
  libzip \
  linux-headers \
  lz4-libs \
  openssh-client \
  ${PHPIZE_DEPS} \
  && install-php-extensions mysqli \
  && install-php-extensions pdo \
  && install-php-extensions pgsql \
  && install-php-extensions pdo_pgsql \
  && install-php-extensions pdo_mysql \
  && install-php-extensions intl \
  && install-php-extensions zip \
  && install-php-extensions opcache \
  && install-php-extensions exif \
  && install-php-extensions bcmath \
  && install-php-extensions xsl \
  && install-php-extensions pcntl \
  && install-php-extensions zip \
  && install-php-extensions sockets \
#  && install-php-extensions grpc \
#  && install-php-extensions protobuf \
  && apk del --no-cache ${PHPIZE_DEPS} \
  && rm -rf /tmp/*


# Install grpc and probuf with pecl
#COPY --from=ghcr.io/redfieldchristabel/php_grpc:8.3 /usr/local/lib/php/extensions/ /usr/local/lib/php/extensions/
#COPY --from=ghcr.io/redfieldchristabel/php_grpc:8.3 /usr/local/etc/php/conf.d/docker-php-ext-grpc.ini /usr/local/etc/php/conf.d/docker-php-ext-grpc.ini
#
#RUN pecl install protobuf && docker-php-ext-enable grpc protobuf
#
### Enable grpc and protobuf extensions in php.ini file
#RUN echo starting && \
#    docker-php-ext-enable grpc && \
#    docker-php-ext-enable protobuf

ARG DB_HOST
ENV DB_HOST=$DB_HOST

ARG DB_DATABASE
ENV DB_DATABASE=$DB_DATABASE

ARG DB_USERNAME
ENV DB_USERNAME=$DB_USERNAME

ARG DB_PASSWORD
ENV DB_PASSWORD=$DB_PASSWORD

ARG DB_PORT
ENV DB_PORT=$DB_PORT

ARG APP_NODE
ENV APP_NODE=$APP_NODE
# Copy files
RUN mkdir /src

#Copy php params
COPY .docker/php/conf.d/php.ini /usr/local/etc/php/
COPY .docker/php/conf.d/opcache.ini /usr/local/etc/php/conf.d/opcache.ini
#Copy env
COPY .rr.dev-staging.yaml /src/.rr.yaml
COPY .env.dev-staging /src/.env
# Composer
COPY ./composer.json /src
#App
COPY ./app /src/app
COPY ./public /src/public
COPY ./app.php /src
COPY ./functions.php /src
#Shared
COPY ./shared /src/shared
COPY ./shared-cqrs /src/shared-cqrs
COPY ./shared-temporal /src/shared-temporal

RUN mkdir /src/runtime
RUN mkdir /src/certs

WORKDIR /src

# Composer
ENV COMPOSER_ALLOW_SUPERUSER=1
RUN composer install --no-autoloader --no-scripts && \
    composer clear-cache && \
    composer dump --optimize --no-scripts

# Run RR
EXPOSE 8666
# Health check for RR
EXPOSE 2115

#CMD ["rr", "serve", "-c", ".rr.yaml", "-s"]
CMD ["rr", "serve", "-e", "-c", "/src/.rr.yaml"]
