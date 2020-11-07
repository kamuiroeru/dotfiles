#!/bin/bash

webhook_url=$SLACK_BOT_INCOMING_WEBHOOK
if [ -z $webhook_url ]; then
    exit 1
fi

text="作業が終わりました。"
if [ $# == 1 ]; then
    text=$1
fi

curl \
    -s \
    -o /dev/null \
    -X POST \
    -H 'Content-type: application/json' \
    --data '{"text":"'$text'"}' \
    $webhook_url
