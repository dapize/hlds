FROM debian:bookworm

LABEL creator "Daniel P Z <danielpz@outlook.com>"

RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates
RUN update-ca-certificates
RUN dpkg --add-architecture i386
RUN apt -y update
RUN apt -y install lib32gcc-s1 lib32stdc++6
RUN mkdir -p /opt/hlds

WORKDIR /opt/hlds

COPY server/ .
COPY scripts/hlds_run.sh .
RUN chmod +x hlds_run.sh
RUN mkdir -p ~/.steam && ln -s /opt/hlds ~/.steam/sdk32

EXPOSE 27015
EXPOSE 27015/udp
EXPOSE 26900/udp
EXPOSE 27020/udp

ENTRYPOINT [ "/opt/hlds/hlds_run.sh" ]

