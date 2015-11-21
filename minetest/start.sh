#!/bin/sh

if [ ! -d "/minetest" ]; then
  mkdir /minetest
fi

if [ ! -f "/minetest/minetest.conf" ]; then
  cp /etc/minetest/minetest.conf /minetest/minetest.conf
fi

if [ "minetest_game" = $GAMEID ] && [ ! -d "/games/minetest_game" ]; then
  unzip /tmp/minetest_game.zip -d /games/ && \
    mv /games/minetest_game-*/ /games/minetest_game
fi

chown -R minetest:minetest /games /minetest

cd /minetest

su - minetest -c "exec minetestserver --config /minetest/minetest.conf --world /minetest/world"
