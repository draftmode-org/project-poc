#!/bin/bash

CONTAINER="php"
BASH_CMD="sh -c"

function exit_help() {
    if [[ -n ${1} ]];then
      echo "$(tput setaf 1)[$(date)] ${1}$(tput sgr 0)"
      echo
    fi
    echo "Usage: php-composer.sh <command> [...options]"
    echo
    echo "options:"
    echo "   update <package-name>                update for given package"
    echo "   install                              install"
    echo "   require <package-name> <version>     require for given package and version"
    echo "   require-dev <package-name> (version) require-dev for given package and version (optional)"
    echo "   remove <package-name>                remove given package"
    echo
    echo "additional options:"
    echo "   --container (CONTAINER)              use another container (default: ${CONTAINER})"
    echo "   --preview                            just build the command(s) to be executed and print it"
    echo
    if [[ -n ${1} ]];then
      exit 1
    fi
}

y=0
ARGUMENTS=( "$@" )
while [[ $y -lt ${#ARGUMENTS[@]} ]]
do
  ARGUMENT=${ARGUMENTS[$y]}
  case ${ARGUMENT} in
    --container)
      (( y++))
      ARGUMENT=${ARGUMENTS[$y]}
      if [[ -z ${ARGUMENT} ]];then
        exit_help "<container-name> missing"
      fi
      CONTAINER=${ARGUMENT}
    ;;
    --preview)
      PREVIEW=1
    ;;
    install)
      CMD="COMPOSER_DISCARD_CHANGES=true composer ${ARGUMENT} --no-interaction"
    ;;
    update)
      (( y++))
      PACKAGE_NAME=${ARGUMENTS[$y]}
      if [[ -z ${PACKAGE_NAME} ]];then
        exit_help "<package-name> missing"
      fi
      CMD="COMPOSER_DISCARD_CHANGES=true composer update ${PACKAGE_NAME} --no-interaction"
    ;;
    require)
      (( y++))
      PACKAGE_NAME=${ARGUMENTS[$y]}
      if [[ -z ${PACKAGE_NAME} ]];then
        exit_help "<package-name> for command require missing"
      fi
      (( y++))
      VERSION=${ARGUMENTS[$y]}
      if [[ -z ${VERSION} ]];then
        exit_help "<version> for for command require ${PACKAGE_NAME} missing"
      fi
      CMD="composer require ${PACKAGE_NAME}:${VERSION}"
    ;;
    require-dev)
      (( y++))
      PACKAGE_NAME=${ARGUMENTS[$y]}
      if [[ -z ${PACKAGE_NAME} ]];then
        exit_help "<package-name> for command require missing"
      fi
      (( y++))
      VERSION=${ARGUMENTS[$y]}
      if [[ -z ${VERSION} ]];then
        CMD="composer require ${PACKAGE_NAME} --dev"
      else
        CMD="composer require ${PACKAGE_NAME}:${VERSION} --dev"
      fi
    ;;
    remove)
      (( y++))
      PACKAGE_NAME=${ARGUMENTS[$y]}
      if [[ -z ${PACKAGE_NAME} ]];then
        exit_help "<package-name> for command remove missing"
      fi
      CMD="composer remove ${PACKAGE_NAME}"
    ;;
    --help)
      exit_help
    ;;
    *)
      exit_help "option ${ARGUMENT} not supported"
    ;;
  esac
  (( y++))
done
if [[ -z ${CMD} ]];then
  exit_help "<command> missing"
fi

echo
echo "[$(date)] start execute command: docker exec -it ${CONTAINER} ${BASH_CMD} ${CMD}"
start=(date +%s)
if [[ -z ${PREVIEW} ]]; then
  (docker exec -it ${CONTAINER} ${BASH_CMD} "${CMD}")
fi
end=(date +%s)
runtime=$((end-start))
echo "[$(date)] end execute command: (runtime: ${runtime} sec)"
echo