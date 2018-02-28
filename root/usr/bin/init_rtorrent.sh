#!/bin/bash

set -e

# Create directories
mkdir -p /config/.session \
         /config/watch/start \
         /config/watch/load \
         /config/log \
         /downloads
							
if [ ! -f /config/.rtorrent.rc ]; then
	cp /default/.rtorrent.rc /config/
fi

ln -s /config/.rtorrent.rc /home/rtorrent/

rm -f /config/.session/rtorrent.lock

# Script use for this bug -> https://github.com/docker/docker/issues/8755
#script -qc "tmux -2 new-session -d -s rtorrent rtorrent" /dev/null
#tmux -2 new-session -d -s rtorrent rtorrent
rtorrent
