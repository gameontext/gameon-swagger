FROM nginx

MAINTAINER Ben Smith

ADD https://download.elastic.co/logstash-forwarder/binaries/logstash-forwarder_linux_amd64 /opt/forwarder
ADD https://admin:PLACEHOLDER_ADMIN_PASSWORD@game-on.org:8443/logstashneeds.tar /opt/logstashneeds.tar
ADD https://admin:PLACEHOLDER_ADMIN_PASSWORD@game-on.org:8443/swagger-ui.tar /opt/www/swagger-ui.tar

RUN cd /opt ; chmod +x ./forwarder ; tar xvzf logstashneeds.tar ; rm logstashneeds.tar ; \
	cd /opt/www ; tar xvzf swagger-ui.tar ; rm swagger-ui.tar

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./index.html /opt/www/index.html
COPY ./startup.sh /opt/startup.sh
COPY ./forwarder.conf /opt/forwarder.conf

EXPOSE 8080

CMD ["/opt/startup.sh"]

ADD ./swagger.json /opt/www/
