#!/bin/bash -e
PATH=$PATH:/usr/local/bin
cd /webapp
echo "cron-executor.sh -> running: $@"
exec "$@" >/proc/1/fd/1 2>/proc/1/fd/2
