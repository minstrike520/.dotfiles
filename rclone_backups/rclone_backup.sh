#! /usr/bin/bash

DEST=$*

if [ -z "$DEST" ]; then
  echo "Missing argument: DEST"
  exit 1
fi

rclone sync ./ "$DEST" --filter-from rclone_filter --verbose --config rclone_config
