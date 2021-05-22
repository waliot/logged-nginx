#!/bin/bash
set -e

export PATH="$PATH:/usr/sbin"

START=$(date +%Y-%m-%d-%H:%M:%S)
echo "Running a job at $START"

mv /var/log/nginx/access.log /var/log/nginx/archive/access_$START.log
mv /var/log/nginx/error.log /var/log/nginx/archive/error_$START.log

nginx -s reopen
sleep 1

gzip /var/log/nginx/archive/access_$START.log
gzip /var/log/nginx/archive/error_$START.log

find /var/log/nginx/archive/*.log.gz -mtime +7 -type f -delete

END=$(date +%Y-%m-%d-%H:%M:%S)
echo "Job is done at $END"
