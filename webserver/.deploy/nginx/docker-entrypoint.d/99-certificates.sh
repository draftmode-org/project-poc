#!/bin/sh
set -e
if [[ ! -z ${APP_DOMAIN} ]]; then
  LOG_DATE=$(date +'%Y/%m/%d %H:%M:%S')
  VALID_EXPIRE_DAYS=1
  VALID_EXPIRE_HOURS=$(($VALID_EXPIRE_DAYS*24))
  VALID_EXPIRE_MINUTES=$(($VALID_EXPIRE_HOURS*60))
  VALID_EXPIRE_SECONDS=$((VALID_EXPIRE_MINUTES*60))
  SSL_VALID_DAYS=365
  case ${SSL_HANDLER} in
    openssl)
      echo "${LOG_DATE} [notice] create certificate for ${APP_DOMAIN} via ${SSL_HANDLER}"
      SSL_CERT_PATH="/etc/nginx/certs"
      # create certs directory, if not exists
      [ -d ${SSL_CERT_PATH} ] || mkdir ${SSL_CERT_PATH}
      # setup key,crt file names
      SSL_KEY_FILE="${SSL_CERT_PATH}/${APP_DOMAIN}.key"
      SSL_CRT_FILE="${SSL_CERT_PATH}/${APP_DOMAIN}.crt"
      # verify if cert is valid
      if openssl x509 -checkend ${VALID_EXPIRE_SECONDS} -noout -in ${SSL_CRT_FILE}
      then
        echo "${LOG_DATE} [notice] certificate is valid and will not expire within ${VALID_EXPIRE_HOURS} hours!"
      else
      # create cert if invalid, or going to be expired
        echo "${LOG_DATE} [notice] certificate has expired, will expire within ${VALID_EXPIRE_HOURS} hours, is invalid, not found!"
        echo "${LOG_DATE} [notice] start creating certificate for ${SSL_VALID_DAYS} days"

        # create new cert in .tmp files
        openssl req -x509 -nodes -days ${SSL_VALID_DAYS} -newkey rsa:2048 -subj "/CN=*.${APP_DOMAIN}" -keyout ${SSL_KEY_FILE}.tmp -out ${SSL_CRT_FILE}.tmp

        # verify if file exists
        if [[ -f ${SSL_KEY_FILE}.tmp ]]; then
          echo "${LOG_DATE} [notice] ${SSL_KEY_FILE} created successful"
        fi
        if [[ -f ${SSL_CRT_FILE}.tmp ]]; then
          echo "${LOG_DATE} [notice] ${SSL_CRT_FILE} created successful"
        fi

        # verify new certificate
        if openssl x509 -checkend ${VALID_EXPIRE_SECONDS} -noout -in ${SSL_CRT_FILE}.tmp
        then
          mv ${SSL_KEY_FILE}.tmp ${SSL_KEY_FILE}
          mv ${SSL_CRT_FILE}.tmp ${SSL_CRT_FILE}
          chmod 644 ${SSL_KEY_FILE} ${SSL_CRT_FILE}
          echo "${LOG_DATE} [notice] certificate created successful"
        else
          echo "${LOG_DATE} [error] created certification is invalid, could not be created"
          rm ${SSL_KEY_FILE}.tmp ${SSL_CRT_FILE}.tmp
        fi
      fi
    ;;
    certbot)
      echo "${LOG_DATE} [notice] create certificates for ${APP_DOMAIN} via ${SSL_TYPE}"
    ;;
    *)
      echo "${LOG_DATE} [warning] certificate can not be verified/created, ENV SSL_TYPE missing or given value not valid (openssl, certbot)"
    ;;
  esac
fi

exec "$@"

nginx -g "daemon off;"