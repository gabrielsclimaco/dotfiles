#!/bin/sh
STATUS=$(mullvad status | awk '{ print $1 }')
DISCONNECTED_STRING="Disconnected"

if [ $STATUS == $DISCONNECTED_STRING ] ; then
    echo 0
else
    echo 1
fi
