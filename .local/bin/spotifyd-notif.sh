#!/bin/bash

if [ "$PLAYER_EVENT" = "start" ] || [ "$PLAYER_EVENT" = "change" ];
then
        trackName=$(playerctl metadata title)
        artistAndAlbumName=$(playerctl metadata --format "{{ artist }} ({{ album }})")

        notify-send -u low "$trackName" "$artistAndAlbumName " --icon=library-music
fi
