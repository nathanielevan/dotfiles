#!/bin/sh

if [ "$PLAYER_EVENT" = "start" ] || [ "$PLAYER_EVENT" = "change" ];
then
        trackData=$(playerctl metadata --format "{{ title }}
{{ artist }}
{{ album }}")

        trackTitle=`echo "${trackData}" | head -1`
        trackArtistAlbum=`echo "${trackData}" | tail -2`
        notify-send -u low "$trackTitle" "$trackArtistAlbum" --icon=library-music
fi
