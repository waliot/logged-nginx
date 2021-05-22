# Logged NGINX

The same `NGINX` but with logs compression, rotation and retention.

Every midnight new access and error log files start, the previous day's logs will be compressed. 
All compressed logs older than one week will be deleted.

## Getting started

All logs are stored in the directory `/var/log/nginx/`.

* `/var/log/nginx/access.log` - current access logs

* `/var/log/nginx/error.log` - current error logs

* `/var/log/nginx/job.log` - logs of the cron job

* `/var/log/nginx/archive/` - directory with compressed logs

## Running via Docker

### Start with `docker run`

```bash
$ docker build -t logged-nginx .
$ docker volume create nginx_log
$ docker run --name logged-nginx \
    --restart unless-stopped \
    -v $(pwd)/nginx.conf:/etc/nginx/nginx.conf \
    -v nginx_log:/var/log/nginx \
    -p 80:80 \
    -d logged-nginx:latest
```

### Start with `docker-compose`

```bash
$ docker-compose build
$ docker-compose up
```

### Some useful stuff

Check the `nginx` is working:

```bash
$ curl -X GET localhost:80
> Hello, World!
```

Show the cron job logs:

```bash
$ docker exec logged-nginx tail /var/log/nginx/job.log
```

Search with `grep` in today's access logs:

```bash
$ docker exec logged-nginx grep '"GET / HTTP/1.1" 200' /var/log/nginx/access.log
```

Search with `zgrep` in all archived logs:

```bash
$ docker exec logged-nginx bash -c 'find /var/log/nginx/archive/*.log.gz | xargs zgrep "http://localhost/"'
```
