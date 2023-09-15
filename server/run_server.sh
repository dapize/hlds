#!/bin/sh

set -axe

CONFIG_FILE="/opt/hlds/startup.cfg"h,

if [ -r "${CONFIG_FILE}" ]; then
    set +e
    source "${CONFIG_FILE}"
    set -e
fi

EXTRA_OPTIONS="$@"

EXECUTABLE="/opt/hlds/hlds_run"
MAXPLAYERS="${MAXPLAYERS:-32}"
START_MAP="${START_MAP:-crossfire}"
SERVER_NAME="${SERVER_NAME:-Half-life dedicated server}"
SV_LAN="${SV_LAN:-0}"

OPTIONS="-game valve\
 +maxplayers ${MAXPLAYERS}\
 +map ${START_MAP}\
 +hostname \"${SERVER_NAME}\"\"

if [ -z "${RESTART_ON_FAIL}" ]; then
    OPTIONS="${OPTIONS} -norestart"
fi

if [ -z "${SV_LAN}" ]; then
    OPTIONS="${OPTIONS} +sv_lan 0"
fi

if [ -n "${INSECURE}" ]; then
    OPTIONS="${OPTIONS} -insecure"
fi

if [ -n "${SECURE}" ]; then
    OPTIONS="${OPTIONS} -secure"
fi

if [ -n "${SERVER_PASSWORD}" ]; then
    OPTIONS="${OPTIONS} +sv_password ${SERVER_PASSWORD}"
fi

if [ -n "${RCON_PASSWORD}" ]; then
    OPTIONS="${OPTIONS} +rcon_password ${RCON_PASSWORD}"
fi

set > "${CONFIG_FILE}"

exec "${EXECUTABLE}" "${OPTIONS}" "${EXTRA_OPTIONS}"
