FROM arm32v6/alpine:3.6
LABEL maintainer="Dan Milon <i@danmilon.me>"

# Based on https://github.com/TheZ3ro/docker-tor-relay

ENV TORRC=/etc/tor/torrc.middle
ENV TOR_NICKNAME=my-node
ENV TOR_CONTACT_INFO=Anonymous

RUN apk add \
    --repository http://dl-cdn.alpinelinux.org/alpine/latest-stable/community \
    --no-cache \
    gettext \
    tor

# default port to used for incoming Tor connections
# can be changed by changing 'ORPort' in torrc
EXPOSE 9001/tcp

COPY root /
VOLUME /var/lib/tor

ENTRYPOINT ["/etc/tor/config.sh"]
