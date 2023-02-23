#!/bin/bash

CONTAINER="frontend"
BASH_CMD="sh -c"

function exit_help() {
    if [[ -n ${1} ]];then
      echo "$(tput setaf 1)[$(date)] ${1}$(tput sgr 0)"
      echo
    fi
    echo "Usage: npm.sh <command> [...options]"
    echo
    echo "command:"
    echo "   all given commands are forward 1:1, there is no limitation/verification"
    echo
    echo "options:"
    echo "   all given options are forward 1:1, there is no limitation/verification"
    echo
    echo "additional options:"
    echo "   --container (CONTAINER)              use another container (default: ${CONTAINER})"
    echo "   --preview                            just build the command(s) to be executed and print it"
    echo "   --help"
    echo
    if [[ -n ${1} ]];then
      exit 1
    fi
}

case ${1} in
  --help)
    exit_help;
  ;;
  *)
    COMMAND=${1}
  ;;
esac
if [[ -z ${COMMAND} ]]; then
  exit_help "argument <command> missing";
fi

y=1
ARGUMENTS=( "$@" )
OPTIONS=()
while [[ $y -lt ${#ARGUMENTS[@]} ]]
do
  ARGUMENT=${ARGUMENTS[$y]}
  case ${ARGUMENT} in
    --preview)
      PREVIEW=1
    ;;
    --container)
      (( y++))
      CONTAINER=${ARGUMENTS[$y]}
    ;;
    *)
      OPTIONS+=("${ARGUMENT}")
    ;;
  esac
  (( y++))
done

start=(date +%s)
EXECUTE="${COMMAND} ${OPTIONS[*]}"

echo
echo "[$(date)] start execute command: docker exec -it ${CONTAINER} ${BASH_CMD} npm ${EXECUTE}"
if [[ -z ${PREVIEW} ]]; then
  (docker exec -it ${CONTAINER} ${BASH_CMD} "npm ${EXECUTE}")
fi
end=(date +%s)
runtime=$((end-start))
echo "[$(date)] end execute command: (runtime: ${runtime} sec)"
echo