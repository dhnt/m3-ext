#!/usr/bin/env bash

set -x

source setenv.sh

##
GOARCH=amd64
for i in "${goos[@]}"; do
    name=${i}_${GOARCH}
    mv $GOPATH/bin/$name/* dist/$name
    rmdir $GOPATH/bin/$name
done

## move host binary
GOHOSTOS=`go env GOHOSTOS`
GOHOSTARCH=`go env GOHOSTARCH`

mv $GOPATH/bin/* dist/${GOHOSTOS}_${GOHOSTARCH}
rmdir $GOPATH/bin

# tar -zcvf m3-ext.tar.gz dist/

echo "Package done!"



