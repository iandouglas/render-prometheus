FROM python:3.12
ARG prometheus_version=2.51.1
ENV DATA_PATH $DATA_PATH

RUN apt update
RUN apt install -y wget
RUN wget https://github.com/prometheus/prometheus/releases/download/v${prometheus_version}/prometheus-${prometheus_version}.linux-amd64.tar.gz
RUN tar -xvzf prometheus-${prometheus_version}.linux-amd64.tar.gz -C /etc/
RUN mv /etc/prometheus-${prometheus_version}.linux-amd64 /etc/prometheus
RUN ln -s /etc/prometheus/prometheus /usr/local/bin

COPY --chown=1000:0 config/prometheus.yml /etc/prometheus/prometheus.yml

CMD /etc/prometheus/prometheus --config.file=/etc/prometheus/prometheus.yml --web.listen-address=0.0.0.0:$PORT --storage.tsdb.path=${DATA_PATH}
