FROM nginx

LABEL maintainer="Erin Schnabel <schnabel@us.ibm.com> (@ebullientworks)"

ADD https://download.elastic.co/logstash-forwarder/binaries/logstash-forwarder_linux_amd64 /opt/forwarder

RUN apt-get update && apt-get install -y wget procps \
  && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/coreos/etcd/releases/download/v2.2.2/etcd-v2.2.2-linux-amd64.tar.gz -q \
  && tar xzf etcd-v2.2.2-linux-amd64.tar.gz etcd-v2.2.2-linux-amd64/etcdctl --strip-components=1 \
  && rm etcd-v2.2.2-linux-amd64.tar.gz \
  && mv etcdctl /usr/local/bin/etcdctl

COPY ./nginx.conf        /etc/nginx/nginx.conf
COPY ./nginx-common.conf /etc/nginx/nginx-common.conf
COPY ./nginx-nolog.conf  /etc/nginx/nginx-nolog.conf
COPY ./startup.sh /opt/startup.sh
COPY ./forwarder.conf /opt/forwarder.conf

ENV VERSION=3.1.6

RUN mkdir -p /opt/www \
  && wget https://github.com/swagger-api/swagger-ui/archive/v${VERSION}.tar.gz -q \
  && tar xzvf v${VERSION}.tar.gz --strip-components=2 -C /opt/www swagger-ui-${VERSION}/dist \
  && rm v${VERSION}.tar.gz

COPY ./lib/crypto-js/* /opt/www/lib/crypto-js/
COPY ./index.html /opt/www/index.html

ADD ./gameontext.json /opt/www/
ADD ./gameontext.yaml /opt/www/

EXPOSE 8080

CMD ["/opt/startup.sh"]

HEALTHCHECK \
  --timeout=10s \
  --start-period=40s \
  CMD wget -q -O /dev/null --no-check-certificate http://localhost:8080/health
