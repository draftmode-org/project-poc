#!/bin/bash

CONTAINER="php"
BASH_CMD="sh -c"

function exit_help() {
    if [[ -n ${1} ]];then
      echo "$(tput setaf 1)[$(date)] ${1}$(tput sgr 0)"
      echo
    fi
    echo "Usage: php-composer.sh [...commands]"
    echo
    echo "commands:"
    echo "   all given commands are forward 1:1, there is no limitation/verification"
    echo
    echo "additional commands:"
    echo "   --container (CONTAINER)              use another container (default: ${CONTAINER})"
    echo "   --preview                            just build the command(s) to be executed and print it"
    echo "   --examples                           show examples"
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
    --examples)
      echo
      echo "examples:"
      echo "   make:entity --api-resource           create entity and provide it with CURD as an API resource"
      echo "   doctrine:migrations:diff             generates the migration comparing the db and your current entities"
      echo "   doctrine:schema:drop --force         drop the complete database schema"
      echo
      exit
    ;;
    migration:migrate|xdoctrine:migrations:migrate)
      exit_help "to run ${ARGUMENT}, use docker compose up"
    ;;
    *)
      OPTIONS+=("${ARGUMENT}")
    ;;
  esac
  (( y++))
done

CMD="php bin/console ${OPTIONS[*]}"

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
