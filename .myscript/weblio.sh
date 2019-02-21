#!/bin/zsh

# weblioの環境が無かったら作る

cd `dirname $0`

[ ! -d "./weblio" ] && echo "create env" && zsh ./create_env.sh

./weblio/bin/python ./weblio.py
