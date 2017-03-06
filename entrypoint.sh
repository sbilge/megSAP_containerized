#!/bin/bash
#user add commands for imgag_containerezied

USER_ID=${LOCAL_USER_ID:-9001}

echo "Starting with UID : $USER_ID"
useradd --shell /bin/bash -u $USER_ID -o -c "" -m user
export HOME=/home/user
exec /usr/local/bin/gosu user "$@"

exec /usr/local/bin/gosu user "$@"
