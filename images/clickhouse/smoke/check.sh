set -euo pipefail
ready() { [ "$(clickhouse-client --query 'SELECT 1' 2> /dev/null)" = 1 ]; }
for _ in $(seq 60); do ready && break; sleep 1; done
ready
[ "$(clickhouse-client --query 'SELECT version()')" = "$DATABASIFY_RELEASE" ]
[ "$(printf 'SELECT 1;\nSELECT 2;\n' | clickhouse-client --multiquery | tr '\n' ' ')" = '1 2 ' ]
databasify ctl is-active --quiet server.service
[ "$(databasify ctl show -p NRestarts --value server)" = 0 ]
databasify ctl logs -u server -n 3
clickhouse keeper-client --help > /dev/null
[ "$(id -u clickhouse)" = 64999 ] && [ "$(id -g clickhouse)" = 64999 ]
[ "$(stat -c %u /var/lib/clickhouse)" = 64999 ]
echo "clickhouse $DATABASIFY_RELEASE runs under the databasify supervisor"
