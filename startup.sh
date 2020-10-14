#!/bin/sh

log() {
  if [ "${GAMEON_LOG_FORMAT}" == "json" ]; then
    # This needs to be escaped using jq
    echo '{"message":"'$@'"}'
  else
    echo $@
  fi
}

log "using /tmp/ for config"
cp /etc/nginx/nginx.conf /tmp/nginx.conf

if [ "${GAMEON_MODE}" == "development" ]
then
  # turn off sendfile for local development
  sed -i -e "s/sendfile: .*$/sendfile: off/" /tmp/nginx.conf
else
  # turn on sendfile
  sed -i -e "s/sendfile: .*$/sendfile: on/" /tmp/nginx.conf
fi

if [ "${GAMEON_LOG_FORMAT}" == "json" ]
then
  sed -i -e "s/access\.log .*$/access.log json_combined;/" /tmp/nginx.conf
else
  sed -i -e "s/access\.log .*$/access.log combined;/" /tmp/nginx.conf
fi

log "Init complete. Starting nginx"
exec nginx -c /tmp/nginx.conf
