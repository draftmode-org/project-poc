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
    echo "command:"
    echo "   make:migration"
    echo "   doctrine:database:create"
    echo "   make:entity"
    echo "   make:controller"
    echo
    echo "options:"
    echo "   all given options are forward 1:1, there is no limitation/verification"
    echo
    echo "additional options:"
    echo "   --container (CONTAINER)              use another container (default: ${CONTAINER})"
    echo "   --preview                            just build the command(s) to be executed and print it"
    echo
    echo "blocked commands:"
    echo "   migration:migrate"
    echo "   doctrine:migrations:migrate"
    echo
    if [[ -n ${1} ]];then
      exit 1
    fi
}

y=0
ARGUMENTS=( "$@" )
OPTIONS=()
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
    make:migration|doctrine:database:create|make:entity|make:controller)
      CMD=${ARGUMENT}
    ;;
    migration:migrate|doctrine:migrations:migrate)
      exit_help "to run ${ARGUMENT}, use docker compose up"
    ;;
    --help)
      exit_help
    ;;
    *)
      OPTIONS+=(" ${ARGUMENT}")
    ;;
  esac
  (( y++))
done

if [[ -z ${CMD} ]];then
  exit_help "supported <command> missing"
fi
CMD="php bin/console ${CMD} ${OPTIONS[*]}"

echo
echo "[$(date)] start execute command: docker exec -it ${CONTAINER} ${BASH_CMD} ${CMD}"
start=(date +%s)
if [[ -z ${PREVIEW} ]]; then
#  (docker exec -it ${CONTAINER} ${BASH_CMD} "${CMD}")
   echo "run"
fi
end=(date +%s)
runtime=$((end-start))
echo "[$(date)] end execute command: (runtime: ${runtime} sec)"
echo
