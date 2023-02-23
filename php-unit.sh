#!/bin/bash

CONTAINER="php"
VENDOR_FOLDER="vendor"
BASH_CMD="sh -c"

function exit_help() {
    if [[ -n ${1} ]];then
      echo "$(tput setaf 1)[$(date)] ${1}$(tput sgr 0)"
      echo
    fi
    echo "Usage: php-unit.sh [...options]"
    echo
    echo "options:"
    echo "   all given options are forward 1:1, there is no limitation/verification"
    echo
    echo "additional options:"
    echo "   --container (CONTAINER)              use another container (default: ${CONTAINER})"
    echo "   --vendor (VENDOR FOLDER)             use another vendor folder (default: ${VENDOR_FOLDER})"
    echo "   --preview                            just build the command(s) to be executed and print it"
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
  echo "${ARGUMENT}"
  case ${ARGUMENT} in
    --container)
      (( y++))
      ARGUMENT=${ARGUMENTS[$y]}
      if [[ -z ${ARGUMENT} ]];then
        exit_help "<container-name> missing"
      fi
      CONTAINER=${ARGUMENT}
    ;;
    --vendor)
      (( y++))
      ARGUMENT=${ARGUMENTS[$y]}
      if [[ -z ${ARGUMENT} ]];then
        exit_help "<vendor-folder> missing"
      fi
      VENDOR_FOLDER=${ARGUMENT}
    ;;
    --preview)
      PREVIEW=1
    ;;
    --help)
      exit_help
    ;;
    *)
      OPTIONS+=("${ARGUMENT}")
    ;;
  esac
  (( y++))
done

EXECUTE="${OPTIONS[*]}"
PHPUNIT="./${VENDOR_FOLDER}/bin/phpunit ${EXECUTE}"
echo
echo "[$(date)] start execute command: docker exec -it ${CONTAINER} ${BASH_CMD} ${PHPUNIT}"
start=(date +%s)
if [[ -z ${PREVIEW} ]]; then
  (docker exec -it ${CONTAINER} ${BASH_CMD} "${PHPUNIT}")
fi
end=(date +%s)
runtime=$((end-start))
echo "[$(date)] end execute command: (runtime: ${runtime} sec)"
echo