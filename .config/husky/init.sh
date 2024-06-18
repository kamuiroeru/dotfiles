#/bin/bash

# .nvmrc -> package.json 内 engines.node (メジャーバージョン) の順番で node を適用する

# .nvmrc があればそれを読む
if [ -f .nvmrc ]; then
    node_version=$(cat .nvmrc)
else
    # .nvmrc がなければ、package.json 内の engines.node のメジャーバージョンを読む
    node_major_version_from_package_json=$(cat package.json | jq -r '.engines.node' | cut -d'.' -f1)
    if [ "$node_major_version_from_package_json" != "null" ]; then
        node_version=$node_major_version_from_package_json
    fi
fi

# node_version が分かったら nvm use する
if [ -n "$node_version" ]; then
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && nvm use $node_version
fi

echo nodejs version: $(node -v)
