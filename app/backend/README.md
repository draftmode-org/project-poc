## Backend.simple
The backend.simple example provides
- nginx (for local)
- database (for local)
- php with composer
There are no special plugins or dependencies installed, just for require-dev: phpunit

The php service provides a /public folder and inside an index.php.<br>
This folder is the root folder in the NGINX service configuration [local.conf](docker/nginx/conf.d/local.conf).<br>
All requests are handled across this [index.php](public/index.php).

### Dockerfile
- stage: local
  - php base image within all required libs
  - source will be not copied, cause of mounting via docker-compose.override.yml
  
- stage: webserver
  - regular: nginx image
  - copy /.deploy/nginx/conf.d/local.conf => /etc/nginx/conf.d/default.conf

### docker-compose
- service: php
  - Dockerfile / production
  - no mount (is a part of Dockerfile: build-production)
  - no command (is a part of Dockerfile: production)

### docker-compose.overwrite
[docker-compose.override.yml](docker-compose.override.yml) extends/modify docker-compose with
- service: php
  - mount .:/var/app
  - command: to run, on start, composer install
  - Dockerfile / stage: local
   
- new service: webserver
  - mount
    - ./public:/var/app/public
    - ./docker/nginx/conf.d/local.conf:/etc/nginx/conf.d/default.conf
  - port 
    - public: 8088, internal: 80
  - Dockerfile / stage: webserver

- new service: database
  - image: mariadb:1.0.0
  - port
    - public: 3366, internal: 3306
  - /var/lib/mysql is persistent inside the container

### open issues
- 2023.02.14: finish [Dockerfile](Dockerfile) to build a production image
- 2023.02.14: harmonize logging format with NGINX and Database