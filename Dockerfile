FROM  alpine:latest

RUN apk add --update --no-cache bash \
    curl \
    jq \
    python3 \
    py3-pip \
    && pip3 install --upgrade pip \
    && pip3 install --no-cache-dir awscli \
    && rm -rf /var/cache/apk/*

RUN mkdir /metrics

COPY ./metrics.sh  /metrics/metrics.sh

RUN chmod +x /metrics/metrics.sh

COPY crontab /tmp/crontab

RUN cat /tmp/crontab > /etc/crontabs/root

CMD ["crond", "-f", "-l", "2"]