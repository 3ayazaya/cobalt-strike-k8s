FROM openjdk:23-slim

LABEL maintainer="Daniil Zaytsev <danyazaytsev@gmail.com>"

RUN apt-get update && apt-get install --no-install-recommends -y \
    dos2unix \
    libfreetype6-dev \
 && rm -rf /var/lib/apt/lists/*

COPY ./Server /opt/cobaltstrike

WORKDIR /opt/cobaltstrike

RUN chmod +x ./teamserver \
  && chmod +x ./TeamServerImage \
  && chmod +x ./c2lint \
  && chmod +x ./source-common.sh \
  && dos2unix ./TeamServerImage \
  && dos2unix ./teamserver \
  && mkdir /opt/cobaltstrike/artifacts \
  && mkdir -p /opt/cobaltstrike/data

VOLUME [ "/opt/cobaltstrike" ]

EXPOSE 50050 443 80 53/udp 53/tcp

ENTRYPOINT [ "./teamserver" ]