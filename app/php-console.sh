#!/bin/bash
set -e
CONTAINER="backend"

function exit_help() {
    if [[ -n ${1} ]];then
      echo "$(tput setaf 1)[$(date)]<E> ${1}$(tput sgr 0)"
      echo
    fi
    echo "Usage: php-composer.sh <command> [...options]"
    echo
    echo "arguments:"
    echo "   update <package-name>                run composer update for given package"
    echo "   command:install                      run composer install"
    echo "   require <package-name> <version>     run composer require for given package and version"
    echo "   require-dev <package-name> (version) run composer require-dev for given package and version (optional)"
    echo
    if [[ -n ${1} ]];then
      exit 1
    fi
}
COMMAND=${1}
case ${COMMAND} in
  make:migration)
    CMD="make:migration"
  ;;
  migration:migrate|doctrine:migrations:migrate)
    echo "<I> to migrate/run patches: local-deploy.sh will be called"
  ;;
  make:entity)
    CMD="make:entity"
    if [ -z "${2}" ]; then
      CMD="make:entity --api-resource"
    fi
  ;;
  --help|*)
    exit_help
  ;;
esac

echo "execute: php bin/console ${CMD}"
