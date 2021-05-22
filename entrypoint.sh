#!/bin/bash
set -e

service cron start > /dev/null
nginx -g 'daemon off;'
