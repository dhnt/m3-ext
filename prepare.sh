#!/usr/bin/env bash

set -x

source setenv.sh

# caddy
function prepare_caddy {
    echo "prepare_caddy"

    mkdir -p $GOPATH/src/github.com/mholt
    cd $GOPATH/src/github.com/mholt
    git clone -b m3-v0.11.4 https://github.com/gostones/caddy.git; if [ $? -ne 0 ]; then
        echo "Git repo exists?"
    fi
    go get github.com/caddyserver/builds
    go get github.com/abiosoft/caddy-git
}

##
prepare_caddy

##
echo "Preparation done!"
