## Backend.simple
The backend.simple example provides
- nginx (for local)
- database (for local)
- php with composer
There are no special plugins or dependencies installed, just for require-dev: phpunit

The php service provides a /public folder and inside an index.php.<br>
This folder is the root folder in the NGINX service configuration [local.conf](docker/nginx/conf.d/local.conf).<br>
All requests are handled across this [index.php](public/index.php).

### Dockerfile.local
There are no stages, nothing either a WORKDIR is set. Why? Cause everything's is mounted. 

### Dockerfile.prod
- stage: build-stage
  - based on composer:2.0
  - composer install is executed
  
- stage: test-stage<br>
_this stage can be used to run PHPUNIT (e.g. gitlab.yml)._
  - based on a PHP xdebug version
  - copy all application related folders (incl. vendor)
  - copy all test related folders
- stage: production
  - copy all application related folders (incl. vendor)
