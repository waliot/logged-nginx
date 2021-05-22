FROM nginx:latest

RUN apt-get update &&\
    apt-get -y install cron

RUN rm -rf /var/log/nginx/*

COPY job.sh /
RUN chmod +x /job.sh

RUN mkdir /var/log/nginx/archive
RUN echo "0 0 * * * bash /job.sh >> /var/log/nginx/nginx-cron.log 2>&1" | crontab -

CMD ["/bin/bash", "-c" , "service cron start && nginx -g 'daemon off;'"]
