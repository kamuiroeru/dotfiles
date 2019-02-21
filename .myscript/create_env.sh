#!/bin/bash

# weblio.pyを動かすための環境を作成

python -m venv weblio --without-pip
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
./weblio/bin/python get-pip.py
./weblio/bin/pip install -r requirements.txt
rm -rf get-pip.py
