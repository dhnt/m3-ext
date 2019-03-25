#!/usr/bin/env bash

set -x

source setenv.sh

##
GOARCH=amd64
for i in "${goos[@]}"; do
    name=${i}_${GOARCH}
    mkdir -p dist/$name
    mv $GOPATH/bin/$name/* dist/$name
    rmdir $GOPATH/bin/$name
done

## move host binary
GOHOSTOS=`go env GOHOSTOS`
GOHOSTARCH=`go env GOHOSTARCH`

mv $GOPATH/bin/* dist/${GOHOSTOS}_${GOHOSTARCH}
rmdir $GOPATH/bin

#
for i in "${goos[@]}"; do
    name=${i}-${GOARCH}
    tar -zcvf dist/m3-ext.${TAG_NAME}.${name}.tar.gz -C dist ${i}_${GOARCH}
done

echo "Package done!"



