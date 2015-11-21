FROM alpine:edge

MAINTAINER peter@reisz.tk

ENV GAMEID=minetest_game

VOLUME /minetest

VOLUME /games

ADD start.sh /

EXPOSE 30000

RUN echo "http://dl-4.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
  && adduser -D minetest minetest \
  && chmod +x start.sh \
  && apk add --update minetest-server \
  && mv /usr/share/minetest/games /games \
  && ln -s /games /usr/share/minetest/games \
  && wget https://github.com/minetest/minetest_game/archive/0.4.13.zip -O /tmp/minetest_game.zip \
  && rm -rf /var/lib/apt/lists/*

CMD ["/bin/sh", "/start.sh"]
