FROM nginx:1.25.2

RUN apt-get update &&\
    apt-get install -y cron &&\
    rm -rf /var/lib/apt/lists/*

RUN rm -rf /var/log/nginx/*

COPY job.sh /
RUN echo "0 0 * * * bash /job.sh >> /var/log/nginx/job.log 2>&1" | crontab -
RUN mkdir /var/log/nginx/archive

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
CMD ["./entrypoint.sh"]
