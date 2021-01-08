#!/bin/bash

webhook_url=$SLACK_BOT_INCOMING_WEBHOOK
if [ -z $webhook_url ]; then
    exit 1
fi

text="作業が終わりました。"
if [ $# -ge 1 ]; then
    text="$(IFS=' '; echo $*)"
fi

echo $#
echo $text

curl \
    -s \
    -o /dev/null \
    -X POST \
    -H 'Content-type: application/json' \
    --data @- \
    $webhook_url << EOS
{"text": "$text"}
EOS

