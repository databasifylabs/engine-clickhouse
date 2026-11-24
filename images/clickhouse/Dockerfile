# check=skip=InvalidDefaultArgInFrom
ARG BASE_IMAGE

FROM ghcr.io/databasifylabs/engine-sdk:1.0.0@sha256:cf066886a156193196e9d043e3f75e9084928948e40bdd950b2306f2b340d901 AS sdk

FROM ${BASE_IMAGE}
ARG RELEASE
ARG SDK_VERSION
ARG LINE
ARG PACKAGES
RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends $PACKAGES; \
    rm -rf /var/lib/apt/lists/*
RUN set -eux; \
    groupmod -g 64999 clickhouse; \
    usermod -u 64999 -g 64999 clickhouse; \
    find / -xdev \( -uid 101 -o -gid 101 \) -exec chown -h 64999:64999 {} +
COPY --from=sdk /databasify /usr/local/bin/databasify
LABEL org.opencontainers.image.source="https://github.com/databasifylabs/engine-clickhouse" \
      io.databasify.engine="clickhouse" \
      io.databasify.release="${RELEASE}" \
      io.databasify.line="${LINE}" \
      io.databasify.sdk="${SDK_VERSION}"
ENV DATABASIFY_ENGINE=clickhouse \
    DATABASIFY_RELEASE=${RELEASE} \
    DATABASIFY_LINE=${LINE}
STOPSIGNAL SIGTERM
ENTRYPOINT ["/usr/local/bin/databasify", "serve"]
CMD []
