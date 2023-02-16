#!/bin/bash
set -e
DOCKER_COMPOSE_LOCAL="docker-compose.local.yml"

function exit_help() {
    if [[ -n ${1} ]];then
      echo "$(tput setaf 1)[$(date)]<E> ${1}$(tput sgr 0)"
      echo
    fi
    echo "Usage: docker-compose.sh <command> [...options]"
    echo
    echo "arguments:"
    echo "   command                        regular docker compose [METHOD]s"
    echo "                                  up|down|exec|logs|start|stop|run|build|ps"
    echo "   ...options"
    echo "                                  all options supported by npm commands"
    echo "   (additional options):"
    echo "      --local                     use additional ${DOCKER_COMPOSE_LOCAL}"
    echo "      --preview                   just build the command(s) to be executed and print it"
    echo
    if [[ -n ${1} ]];then
      exit 1
    fi
}
COMPOSE_FILES=()
OPTIONS=()
COMMAND=${1}
case ${COMMAND} in
  --help)
    exit_help;
  ;;
  up|down|exec|logs|start|stop|run|build|ps)
    CMD="${COMMAND}"
  ;;
  *)
    exit_help "METHOD ${COMMAND} not supported"
  ;;
esac
if [[ -z ${CMD} ]]; then
  exit_help "argument <METHOD> missing";
fi

y=1
ARGUMENTS=( "$@" )
while [[ $y -lt ${#ARGUMENTS[@]} ]]
do
  ARGUMENT=${ARGUMENTS[$y]}
  case ${ARGUMENT} in
    --local)
      case ${CMD} in
        down)
        ;;
        *)
          COMPOSE_FILES+=("-f docker-compose.yml")
          COMPOSE_FILES+=("-f ${DOCKER_COMPOSE_LOCAL}")
        ;;
      esac
    ;;
    --preview)
      PREVIEW=1
    ;;
    *)
      OPTIONS=("${ARGUMENT}")
    ;;
  esac
  (( y++))
done

start=(date +%s)
EXECUTE="docker-compose ${COMPOSE_FILES[*]} ${CMD} ${OPTIONS[*]}"
echo "[$(date)]<I> start execute command: ${EXECUTE}"
if [[ -z ${PREVIEW} ]]; then
  ${EXECUTE}
fi
end=(date +%s)
runtime=$((end-start))
echo "[$(date)]<I> end execute command: (runtime: ${runtime} sec)"
echo