#!/bin/bash

# webhook_url が設定されてるかチェック
webhook_url=$SLACK_BOT_INCOMING_WEBHOOK
if [ -z $webhook_url ]; then
    exit 1
fi

# 送るメッセージを設定
text="作業が終わりました。"
if [ $# -ge 1 ]; then
    text="$(IFS=' '; echo $*)"
fi

# _ADD_TIMEが指定されていれば、時刻を前に追加する
if [ -v _ADD_TIME ]; then
    text=$(date "+%Y/%m/%d %H:%M:%S.%3N")"  ${text}"
fi

curl \
    -s \
    -o /dev/null \
    -X POST \
    -H 'Content-type: application/json' \
    --data @- \
    $webhook_url << EOS
{"text": "$text"}
EOS

