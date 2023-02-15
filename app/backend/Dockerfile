ARG IMAGE_NAME
ARG IMAGE_TAG

ARG BASE_IMAGE_TAG
FROM composer:2.0 as build-stage
WORKDIR /app
COPY composer.json ./composer.json
COPY composer.lock ./composer.lock

ENV COMPOSER_CACHE_DIR=/app/.cache/composer

RUN composer install \
    --ignore-platform-reqs \
    --no-interaction \
    --no-plugins \
    --no-scripts \
    --prefer-dist

FROM ${IMAGE_NAME}:${IMAGE_TAG} as test-stage

WORKDIR /var/app

COPY --from=build-stage /app/vendor/ ./vendor
COPY ./src ./src
COPY ./public ./public


ARG NGINX_IMAGE_NAME=nginx
ARG NGINX_IMAGE_TAG=1.23.3-alpine

FROM ${IMAGE_NAME}:${IMAGE_TAG} as local
WORKDIR /var/app

FROM ${NGINX_IMAGE_NAME}:${NGINX_IMAGE_TAG} as webserver
WORKDIR /var/app
