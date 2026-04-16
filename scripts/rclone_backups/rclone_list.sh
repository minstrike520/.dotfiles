#! /usr/bin/bash

rclone ls ./ --filter-from rclone_filter --verbose --config rclone_config
