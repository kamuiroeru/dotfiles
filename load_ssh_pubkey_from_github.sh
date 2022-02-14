#!/bin/bash

# GitHub から 公開鍵をダウンロードして、配置する

GITHUB_USERNAME=$1
if [ $# -eq 0 ]; then
    # 引数に無い場合は 入力させる
    read -p "GitHubUsername: " GITHUB_USERNAME
fi

GITHUB_PUBKEY_URL="https://github.com/${GITHUB_USERNAME}.keys"

# Github User が存在するかチェック
STATUS_CODE=$(curl -I "https://github.com/${GITHUB_USERNAME}" -o /dev/null -w '%{http_code}\n' -s)
if [ $STATUS_CODE -ne 200 ]; then
    echo "ERROR: Not Found \"${GITHUB_USERNAME}\" in GitHub."
    exit 1
fi

# Github User の公開鍵が存在するかチェック
PUBKEYS=$(curl -s $GITHUB_PUBKEY_URL)
if [ -z "$PUBKEYS" ]; then
    echo "ERROR: ${GITHUB_USERNAME}'s public keys are nothing."
    exit 1
fi

# 公開鍵を追記
# Create directory
mkdir -p $HOME/.ssh
echo '' >> $HOME/.ssh/authorized_keys
echo '# -------------------------------------' >> $HOME/.ssh/authorized_keys
echo "# Load from $GITHUB_PUBKEY_URL" >> $HOME/.ssh/authorized_keys
echo "$PUBKEYS" >> $HOME/.ssh/authorized_keys
echo '# -------------------------------------' >> $HOME/.ssh/authorized_keys
chmod 600 $HOME/.ssh/authorized_keys