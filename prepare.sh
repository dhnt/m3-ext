#!/usr/bin/env bash

set -x

source setenv.sh

# ipfs
function prepare_ipfs() {
    echo "prepare_ipfs"
    export GO111MODULE=on

    mkdir -p $GOPATH/src/github.com/gostones
    cd $GOPATH/src/github.com/gostones
    git clone https://github.com/gostones/go-ipfs.git; if [ $? -ne 0 ]; then
        echo "Git repo exists?"
    fi
    cd go-ipfs
    go mod download
}

# web terminal
function prepare_gotty {
    echo "prepare_gotty"
    export GO111MODULE=on

    mkdir -p $GOPATH/src/github.com/gostones
    cd $GOPATH/src/github.com/gostones
    git clone https://github.com/gostones/gotty.git; if [ $? -ne 0 ]; then
        echo "Git repo exists?"
    fi
    cd gotty
    go mod init
    go mod download
}

# caddy
function prepare_caddy {
    echo "prepare_caddy"
    export GO111MODULE=off

    mkdir -p $GOPATH/src/github.com/mholt
    cd $GOPATH/src/github.com/mholt
    git clone -b m3-v0.11.4 https://github.com/gostones/caddy.git; if [ $? -ne 0 ]; then
        echo "Git repo exists?"
    fi
    go get github.com/caddyserver/builds
    go get github.com/abiosoft/caddy-git
}

##
prepare_ipfs
prepare_gotty
prepare_caddy

##
echo "Preparation done!"
