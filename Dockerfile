FROM alpine:3.22

RUN apk add --no-cache \
      ca-certificates \
      openssl \
      stunnel \
      tzdata \
    && update-ca-certificates

RUN mkdir -p /etc/stunnel /certs /run/stunnel

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
COPY stunnel.conf /etc/stunnel/stunnel.conf

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

VOLUME ["/etc/stunnel", "/certs"]

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
