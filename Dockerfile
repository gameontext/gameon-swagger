FROM nginx

MAINTAINER Erin Schnabel <schnabel@us.ibm.com> (@ebullientworks)

ADD https://download.elastic.co/logstash-forwarder/binaries/logstash-forwarder_linux_amd64 /opt/forwarder

RUN apt-get update && apt-get install -y wget procps \
  && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/coreos/etcd/releases/download/v2.2.2/etcd-v2.2.2-linux-amd64.tar.gz -q && \
    tar xzf etcd-v2.2.2-linux-amd64.tar.gz etcd-v2.2.2-linux-amd64/etcdctl --strip-components=1 && \
    rm etcd-v2.2.2-linux-amd64.tar.gz && \
    mv etcdctl /usr/local/bin/etcdctl

COPY ./nginx.conf        /etc/nginx/nginx.conf
COPY ./nginx-common.conf /etc/nginx/nginx-common.conf
COPY ./nginx-nolog.conf  /etc/nginx/nginx-nolog.conf
COPY ./startup.sh /opt/startup.sh
COPY ./forwarder.conf /opt/forwarder.conf

ADD https://github.com/swagger-api/swagger-ui/archive/v2.2.5.tar.gz /opt/swagger-ui.tar
RUN cd /opt && mv swagger-ui.tar/swagger-ui-2.2.5/dist www && rm -rf swagger-ui.tar

COPY ./lib/crypto-js/* /opt/www/lib/crypto-js/
COPY ./index.html /opt/www/index.html

ADD ./swagger.json /opt/www/
ADD ./swagger.yaml /opt/www/

EXPOSE 8080

CMD ["/opt/startup.sh"]

HEALTHCHECK \
  --timeout=10s \
  --start-period=40s \
  CMD wget -q -O /dev/null --no-check-certificate http://localhost:8080/health
