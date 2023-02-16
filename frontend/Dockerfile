ARG NODE_IMAGE_NAME
ARG NODE_IMAGE_TAG
ARG NGINX_IMAGE_NAME
ARG NGINX_IMAGE_TAG
#
# stage: local
#
FROM ${NODE_IMAGE_NAME}:${NODE_IMAGE_TAG} as local

WORKDIR /var/www/html

#
# stage: test-stage (run npm install)
#
FROM local as test-stage

# notice: reused in COPY --from statement
WORKDIR /app

# copy packages + and run npm install
COPY package*.json ./

# install project depencies
RUN npm install
#ISSUE:npm:audit:failure
# RUN npm install && npm audit fix --force

# copy project related files
COPY ./src ./src
COPY ./public ./public
COPY index.html .
COPY tsconfig.json .
COPY .env .
COPY .eslintrc .
COPY .eslintignore .
COPY vite.config.ts .

#
# stage: build-stage (run npm run build, based on test-stage)
#
FROM test-stage as build-stage
RUN npm run build --report

#
# stage: production (NGINX, COPY --from build-stage)
#
FROM ${NGINX_IMAGE_NAME}:${NGINX_IMAGE_TAG} as production

# copy builded context to default nginx folder
COPY --from=build-stage /app/dist /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]