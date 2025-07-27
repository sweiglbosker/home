#!/usr/bin/env sh

TMP_DIR="/tmp/rmpc"

mkdir -p "$TMP_DIR"

ALBUM_ART_PATH="$TMP_DIR/notification_cover"

pkill mako
if ! rmpc albumart --output "$ALBUM_ART_PATH"; then
  notify-send "Now Playing" "$ARTIST - $TITLE"
else
  notify-send -i "${ALBUM_ART_PATH}" "Now Playing" "$ARTIST - $TITLE"
fi

