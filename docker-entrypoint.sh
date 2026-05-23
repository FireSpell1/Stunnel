#!/bin/sh
set -eu

if [ "$#" -gt 0 ]; then
  exec "$@"
fi

STUNNEL_CONF="${STUNNEL_CONF:-/etc/stunnel/stunnel.conf}"
GENERATED_CONF="/tmp/stunnel.generated.conf"

if [ ! -f "$STUNNEL_CONF" ]; then
  echo "stunnel config not found: $STUNNEL_CONF" >&2
  echo "Mount your config to /etc/stunnel/stunnel.conf or set STUNNEL_CONF." >&2
  exit 1
fi

if [ "${UPDATE_CA_CERTIFICATES:-0}" = "1" ]; then
  update-ca-certificates
fi

{
  echo "foreground = yes"
  echo "pid ="
  echo
  cat "$STUNNEL_CONF"
} > "$GENERATED_CONF"

exec stunnel "$GENERATED_CONF"
