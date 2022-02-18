#!/usr/bin/env bash
STREAM_SCRIPT="stream.sh"
CURRENT_DIR="$(dirname "$0")"

PIDFILE=/tmp/stream.pid

if [ -f $PIDFILE ]
then
    PID=$(cat $PIDFILE)
    ps -p $PID > /dev/null 2>&1
    if [ $? -eq 0 ]
    then
        echo "Process already running"
        exit 1
    else
        ## Process not found assume not running
        echo $$ > $PIDFILE
        if [ $? -ne 0 ]
        then
            echo "Could not create PID file"
            exit 2
        fi
    fi
else
    echo $$ > $PIDFILE
    if [ $? -ne 0 ]
    then
        echo "Could not create PID file"
        exit 2
    fi
fi

$CURRENT_DIR/$STREAM_SCRIPT

rm $PIDFILE
exit $?
