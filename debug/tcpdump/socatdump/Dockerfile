FROM debian:stable-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    tcpdump \
    tshark \
    socat \
    iproute2 \
    procps \
    bash \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
#CMD ["/bin/bash"]
