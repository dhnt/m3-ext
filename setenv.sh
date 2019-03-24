function set_env {
    export DHNT_BASE=$PWD/build
    export GOPATH=$DHNT_BASE/go
    #
    mkdir -p $DHNT_BASE/go
}

##
set_env

goos=(
darwin
linux
windows
)
##