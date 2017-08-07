FROM arm32v6/alpine:3.6
LABEL maintainer="Dan Milon <i@danmilon.me>"

# Based on https://github.com/TheZ3ro/docker-tor-relay

# Note: Tor is only in testing repo -> http://pkgs.alpinelinux.org/packages?package=emacs&repo=all&arch=x86_64
RUN apk update && apk add \
	bash \
	tor \
	--update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ \
	&& rm -rf /var/cache/apk/*

# default port to used for incoming Tor connections
# can be changed by changing 'ORPort' in torrc
EXPOSE 9001

# copy in our torrc files
COPY torrc.bridge /etc/tor/torrc.bridge
COPY torrc.middle /etc/tor/torrc.middle
COPY torrc.exit /etc/tor/torrc.exit

# make sure files are owned by tor user
RUN chown -R tor /etc/tor

# Add launcher
COPY ./config.sh /etc/tor/config.sh

# Start Tor
RUN chmod +x /etc/tor/config.sh

RUN mkdir /home/tor
VOLUME /home/tor/.tor

CMD /etc/tor/config.sh
