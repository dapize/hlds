FROM debian:12.1-slim

LABEL creator "Daniel P Z <danielpz@outlook.com>"

RUN dpkg --add-architecture i386
RUN apt -y update
RUN apt -y install lib32gcc-s1
RUN mkdir -p /opt/hlds

WORKDIR /opt/hlds

COPY server/ .
RUN mkdir -p ~/.steam && ln -s /opt/hlds ~/.steam/sdk32

EXPOSE 27015
EXPOSE 27015/udp
EXPOSE 26900/udp
EXPOSE 27020/udp

ENTRYPOINT [ "/opt/hlds/run_server.sh" ]

