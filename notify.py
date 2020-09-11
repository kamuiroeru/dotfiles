import requests
from sys import argv
import os


if len(argv) > 1:
    text = argv[1]
else:
    text = '作業が終わりました。'


url = os.environ.get('SLACK_BOT_INCOMING_WEBHOOK')
if not url:
    print('Can not get slack incoming webhook url from $SLACK_BOT_INCOMING_WEBHOOK')
    exit(1)

header = {
    'Content-type': 'application/json',
}

data = {
    'text': text
}

r = requests.post(url, json=data, headers=header)
print(r.text)
