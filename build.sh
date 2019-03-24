#!/usr/bin/env bash

set -x

source setenv.sh

##

# args: url
function download_gz {
    temp=temp_$$.tar.gz
    wget --no-check-certificate -q -O ${temp} "$1" 
    tar -xzvf ${temp} -C $DHNT_BASE/dl/${GOOS}_${GOARCH}
    rm ${temp}
}

function download_zip {
    temp=temp_$$.zip
    wget --no-check-certificate -q -O ${temp} "$1"
    unzip ${temp} -d $DHNT_BASE/dl/${GOOS}_${GOARCH}
    rm ${temp}
}

function download_file {
    wget --no-check-certificate -q -O $GOPATH/bin/${GOOS}_${GOARCH}/$2 "$1"
}

# ipfs
function install_ipfs() {
    export GO111MODULE=on

    cd $GOPATH/src/github.com/gostones/go-ipfs; if [ $? != 0 ]; then
        exit 1
    fi
    go install -a -ldflags '-w -extldflags "-static"' ./cmd/ipfs; if [ $? != 0 ]; then
        exit 1
    fi
}

# function install_ipfs {
#     echo "install_ipfs"
#     VERSION=v0.4.19

#     url="https://github.com/ipfs/go-ipfs/releases/download/${VERSION}/go-ipfs_${VERSION}_${GOOS}-${GOARCH}"
#     case "$GOOS" in
#         windows)
#             download_zip "${url}.zip"
#             mv $DHNT_BASE/dl/${GOOS}_${GOARCH}/go-ipfs/ipfs.exe $GOPATH/bin/${GOOS}_${GOARCH}
#             ;;
#         *)
#             download_gz "${url}.tar.gz"
#             mv $DHNT_BASE/dl/${GOOS}_${GOARCH}/go-ipfs/ipfs $GOPATH/bin/${GOOS}_${GOARCH}
#             ;;
#     esac
# }

# git server
function install_gogs {
    echo "install_gogs"

    # export CC=x86_64-linux-musl-gcc
    # export CXX=x86_64-linux-musl-g++ 

    # export GOPATH=$DHNT_BASE/go
    # export GO111MODULE=off

    # mkdir -p $GOPATH/src/github.com/gogs
    # cd $GOPATH/src/github.com/gogs
    # git clone https://github.com/gogs/gogs.git; if [ $? -ne 0 ]; then
    #     echo "Git repo exists?"
    # fi
    # cd gogs
    # git fetch && git fetch --tags
    # git checkout v0.11.79

    # #
    # case "$GOOS" in
    #     darwin)
    #         go install -tags "sqlite cert netgo" -a
    #         ;;
    #     linux)
    #         CGO_ENABLED=1 go install -tags "sqlite cert netgo" -a -ldflags '-w -linkmode external -extldflags "-static"'
    #         ;;
    #     *)
    #         echo "not supported"
    #         exit 1
    # esac

    # #
    # mkdir -p $DHNT_BASE/home/gogs
    # rm -rf $DHNT_BASE/home/gogs/templates
    # rm -rf $DHNT_BASE/home/gogs/public
    # cp -R $GOPATH/src/github.com/gogs/gogs/templates $DHNT_BASE/home/gogs
    # cp -R $GOPATH/src/github.com/gogs/gogs/public $DHNT_BASE/home/gogs
    # #
}

# web terminal
function install_gotty {
    echo "install_gotty"

    export GO111MODULE=on
     case "$GOOS" in
         windows)
            echo "TODO"
            return
            ;;
    esac

    cd $GOPATH/src/github.com/gostones/gotty; if [ $? != 0 ]; then
        exit 1
    fi
    go install -a -ldflags '-w -extldflags "-static"'; if [ $? != 0 ]; then
        exit 1
    fi
}

# traefik
function install_traefik {
    echo "install_traefik"
    VERSION=v1.7.9

    url="https://github.com/containous/traefik/releases/download/${VERSION}/traefik_${GOOS}-${GOARCH}"
    case "$GOOS" in
        windows)
            download_file "${url}.exe" "traefik.exe"
            ;;
        *)
            download_file "${url}" "traefik"
            ;;
    esac

    # export GOPATH=$DHNT_BASE/go
    # export GO111MODULE=auto

    # mkdir -p $GOPATH/src/github.com/containous
    # cd $GOPATH/src/github.com/containous
    # git clone https://github.com/containous/traefik.git; if [ $? -ne 0 ]; then
    #     echo "Git repo exists?"
    # fi
    # cd traefik
    # git checkout v1.7

    # make binary
    # cp dist/traefik $GOPATH/bin/linux_amd64

    # # # go-bindata needs to be executable on the build system
    # # (GOOS=  GOARCH= go get github.com/containous/go-bindata/...)

    # # go generate
    # # go install -a -ldflags '-w -extldflags "-static"' ./cmd/traefik

    # # #web ui
    # # cd $GOPATH/src/github.com/containous/traefik/webui
    # # yarn install
    # # yarn run build

    # # mkdir -p $DHNT_BASE/home/traefik
    # # rm -rf $DHNT_BASE/home/traefik/*
    # # cp -R $GOPATH/src/github.com/containous/traefik/static $DHNT_BASE/home/traefik
}

# reverse proxy
function install_frp {
    echo "install_frp"

    # export GOPATH=$DHNT_BASE/go
    # export GO111MODULE=on

    # mkdir -p $GOPATH/src/github.com/fatedier
    # cd $GOPATH/src/github.com/fatedier
    # git clone -b m3 https://github.com/gostones/frp.git; if [ $? -ne 0 ]; then
    #     echo "Git repo exists?"
    # fi
    # cd frp

    # make
    # cp bin/* $GOPATH/bin/linux_amd64

    # # mkdir -p $DHNT_BASE/etc/frp
    # # cp $GOPATH/src/github.com/fatedier/frp/conf/* $DHNT_BASE/etc/frp/
}

# gost
function install_gost {
    echo "install_gost"

    # export GOPATH=$DHNT_BASE/go
    # export GO111MODULE=off

    # mkdir -p $GOPATH/src/github.com/ginuerzh
    # cd $GOPATH/src/github.com/ginuerzh
    # git clone -b v2.7.2 https://github.com/gostones/gost.git; if [ $? -ne 0 ]; then
    #     echo "Git repo exists?"
    # fi
    # cd gost

    # go install ./cmd/...
}

# etcd
function install_etcd {
    echo "install_etcd"

    # export GOPATH=$DHNT_BASE/go
    # export GO111MODULE=off

    # mkdir -p $GOPATH/src/github.com/etcd-io
    # cd $GOPATH/src/github.com/etcd-io
    # git clone -b v3.3.12 https://github.com/gostones/etcd.git; if [ $? -ne 0 ]; then
    #     echo "Git repo exists?"
    # fi
    # cd etcd

    # ./build
    # cp bin/* $GOPATH/bin/linux_amd64
}

# caddy
function install_caddy {
    echo "install_caddy"

    export GO111MODULE=off

    cd $GOPATH/src/github.com/mholt/caddy; if [ $? != 0 ]; then
        exit 1
    fi
    go install -a ./caddy/...; if [ $? != 0 ]; then
        exit 1
    fi
}

# chisel
function install_chisel {
    echo "install_chisel"

    # export GOPATH=$DHNT_BASE/go
    # export GO111MODULE=on

    # mkdir -p $GOPATH/src/github.com/jpillora
    # cd $GOPATH/src/github.com/jpillora
    # git clone -b 1.3.1 https://github.com/gostones/chisel.git; if [ $? -ne 0 ]; then
    #     echo "Git repo exists?"
    # fi
    # cd chisel

    # go install
}

# filebrowser
function install_filebrowser {
    echo "install_filebrowser"
    VERSION=v2.0.3

    url="https://github.com/filebrowser/filebrowser/releases/download/${VERSION}/${GOOS}-${GOARCH}-filebrowser"
    case "$GOOS" in
        windows)
            download_zip "${url}.zip"
            mv $DHNT_BASE/dl/${GOOS}_${GOARCH}/filebrowser.exe $GOPATH/bin/${GOOS}_${GOARCH}
            ;;
        *)
            download_gz "${url}.tar.gz"
            mv $DHNT_BASE/dl/${GOOS}_${GOARCH}/filebrowser $GOPATH/bin/${GOOS}_${GOARCH}
            ;;
    esac

    # export GOPATH=$DHNT_BASE/go
    # export GO111MODULE=on

    # mkdir -p $GOPATH/src/github.com/gostones
    # cd $GOPATH/src/github.com/gostones

    # git clone --recurse-submodules -b m3-v2.0.3 https://github.com/gostones/filebrowser.git; if [ $? -ne 0 ]; then
    #     echo "Git repo exists?"
    # fi

    # cd filebrowser; if [ $? -ne 0 ]; then
    #     exit 1
    # fi

    # # frontend
    # (cd frontend; npm install; npm run build)

    # # rice tool
    # # go get github.com/GeertJohan/go.rice
    # # go get github.com/GeertJohan/go.rice/rice
    # which rice; if [ $? -ne 0 ]; then
    #     exit 1
    # fi

    # go mod download

    # (export GO111MODULE=off; cd http; rice embed-go)

    # go install
}

# hugo
function install_hugo {
    echo "install_hugo"

    # export GOPATH=$DHNT_BASE/go
    # export GO111MODULE=on

    # mkdir -p $GOPATH/src/github.com/gostones
    # cd $GOPATH/src/github.com/gostones
    # git clone -b release-0.54.0 https://github.com/gostones/hugo.git; if [ $? -ne 0 ]; then
    #     echo "Git repo exists?"
    # fi

    # cd hugo; if [ $? -ne 0 ]; then
    #     exit 1
    # fi

    # go install
}

function install_all {
    install_ipfs
    install_gogs
    install_gotty
    install_traefik
    install_frp
    install_gost
    install_etcd
    install_caddy
    install_chisel
    install_filebrowser
    install_hugo
}

##
rm -rf $GOPATH/bin/
rm -rf $DHNT_BASE/dl/

for i in "${goos[@]}"; do
    export GOOS=$i   
	echo $GOOS
    export GOARCH=amd64
    export CGO_ENABLED=0
    
    mkdir -p $GOPATH/bin/${GOOS}_${GOARCH}
    mkdir -p $DHNT_BASE/dl/${GOOS}_${GOARCH}

    case "$1" in
        ipfs)
            install_ipfs
            ;;
        gogs)
            install_gogs
            ;;  
        gotty)
            install_gotty            
            ;;
        traefik)
            install_traefik
            ;;
        frp)
            install_frp
            ;;
        gost)
            install_gost
            ;;
        etcd)
            install_etcd
            ;;
        caddy)
            install_caddy
            ;;
        chisel)
            install_chisel
            ;;
        fb)
            install_filebrowser
            ;;
        hugo)
            install_hugo
            ;;
        help)
            echo $"Usage: $0 {ipfs|gogs|gotty|traefik|frp|gost|etcd|caddy|chisel|help|_all_}"
            exit 1
            ;;
        *)
            install_all
    esac
done

#
echo "Build done!"

##
