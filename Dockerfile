FROM nginx

MAINTAINER Ben Smith

ADD https://download.elastic.co/logstash-forwarder/binaries/logstash-forwarder_linux_amd64 /opt/forwarder
ADD https://admin:PLACEHOLDER_ADMIN_PASSWORD@game-on.org:8443/logstashneeds.tar /opt/logstashneeds.tar
ADD https://admin:PLACEHOLDER_ADMIN_PASSWORD@game-on.org:8443/swagger-ui.tar.gz /opt/www/swagger-ui.tar.gz

RUN cd /opt ; chmod +x ./forwarder ; tar xvzf logstashneeds.tar ; rm logstashneeds.tar ; \
	cd /opt/www ; tar xvzf swagger-ui.tar.gz ; rm swagger-ui.tar.gz

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./startup.sh /opt/startup.sh
COPY ./forwarder.conf /opt/forwarder.conf

EXPOSE 8080

CMD ["/opt/startup.sh"]

ADD ./swagger.json /opt/www/
