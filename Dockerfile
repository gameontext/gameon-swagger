FROM nginx

MAINTAINER Ben Smith

ADD https://download.elastic.co/logstash-forwarder/binaries/logstash-forwarder_linux_amd64 /opt/forwarder
ADD https://github.com/swagger-api/swagger-ui/archive/v2.1.3.tar.gz /opt/swagger-ui.tar

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./nginx-nolog.conf /etc/nginx/nginx-nolog.conf
RUN  apt-get update ; apt-get install -y wget ; \
	cd /opt ; mkdir www ; \
	tar xz -C ./www --strip-components=2 -f swagger-ui.tar swagger-ui-2.1.3/dist ; rm swagger-ui.tar
COPY ./index.html /opt/www/index.html

EXPOSE 8080

CMD ["/opt/startup.sh"]

COPY ./startup.sh /opt/startup.sh
COPY ./forwarder.conf /opt/forwarder.conf

ADD ./swagger.json /opt/www/
