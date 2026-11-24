# Databasify ClickHouse Engine

The images behind the [ClickHouse plugin](https://github.com/databasifylabs/clickhouse-database-plugin) for [Databasify](https://github.com/databasifylabs/databasify). Each image is the official `clickhouse/clickhouse-server` image, a few tools, and `databasify`, the [engine SDK](https://github.com/databasifylabs/engine-sdk) 1.0 runtime that runs as PID 1. The engine user `clickhouse` is remapped to UID/GID 64999.

There is no engine code here: the plugin's PHP driver and Blade scripts run inside the container through the runtime. This repository changes only when ClickHouse or a bundled tool moves to a new version.

Images are published as `ghcr.io/databasifylabs/databasify-clickhouse`.

## Lines

| Line | Release | Base image |
| ---- | ------- | ---------- |
| 26.3 LTS | 26.3.70.5 | `clickhouse/clickhouse-server:26.3.70.5` (Ubuntu 22.04) |
| 26.8 LTS | 26.8.45.6 | `clickhouse/clickhouse-server:26.8.45.6` (Ubuntu 22.04) |

ClickHouse supports the current LTS and the one before it; LTS releases come in March and August ([support policy](https://clickhouse.com/legal/support-services-policy)).

## Licences

| Component | Licence |
| --------- | ------- |
| ClickHouse | Apache-2.0 |
| engine SDK runtime | Apache-2.0 |
| Ubuntu packages (`procps`, `iproute2`, `jq`, `curl`, `openssl`) | their Ubuntu package licences |

## Testing

See [engine-template](https://github.com/databasifylabs/engine-template#testing): `tools/images.sh check`, `build`, `smoke` and the Trivy scan, run by the `images` workflow on every push.
