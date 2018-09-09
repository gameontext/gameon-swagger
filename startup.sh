#!/bin/sh

if [ "${GAMEON_MODE}" == "development" ]
then
  # turn off sendfile for local development
  sed -i -e "s/sendfile: .*$/sendfile: off/" /etc/nginx/nginx.conf
else
  # turn on sendfile
  sed -i -e "s/sendfile: .*$/sendfile: on/" /etc/nginx/nginx.conf
fi

if [ "${GAMEON_LOG_FORMAT}" == "json" ]
then
  sed -i -e "s/access\.log .*$/access.log json_combined;/" /etc/nginx/nginx.conf
else
  sed -i -e "s/access\.log .*$/access.log combined;/" /etc/nginx/nginx.conf
fi

nginx
