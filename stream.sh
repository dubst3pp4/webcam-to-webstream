#!/usr/bin/env bash
CURRENT_DIR="$(dirname "$0")"

source $CURRENT_DIR/config.conf

ffmpeg \
    -f lavfi \
    -i anullsrc \
    -rtsp_transport tcp \
    -i "$CAMERA_STREAM" \
    -bufsize 5M \
    -tune zerolatency \
    -vcodec libx264 \
    -pix_fmt + -c:v copy -c:a aac \
    -strict experimental \
    -f flv "$PROVIDER_STREAM"
