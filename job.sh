#!/bin/bash
set -e

export PATH="$PATH:/usr/sbin"

DATE=$(date +%Y-%m-%d-%H:%M:%S)

mv /var/log/nginx/access.log /var/log/nginx/archive/nginx_access_$DATE.log
mv /var/log/nginx/error.log /var/log/nginx/archive/nginx_error_$DATE.log

nginx -s reopen
sleep 1

gzip /var/log/nginx/archive/nginx_access_$DATE.log
gzip /var/log/nginx/archive/nginx_error_$DATE.log

find /var/log/nginx/archive/*.log.gz -type f -mtime +7 -delete
