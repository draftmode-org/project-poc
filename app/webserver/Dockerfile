ARG IMAGE_NAME
ARG IMAGE_TAG

#
# stage:local
#
FROM ${IMAGE_NAME}:${IMAGE_TAG} as local

# copy sites configs
COPY .deploy/nginx/conf.d/backend.conf /etc/nginx/backend.conf

#
# stage:production
#
FROM local as production

# copy sites configs
COPY .deploy/nginx/conf.d/frontend.conf /etc/nginx/conf.d/frontend.conf