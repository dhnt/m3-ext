function set_env {
    export DHNT_BASE=$PWD/build
    export GOPATH=$DHNT_BASE/go
    #
    mkdir -p $DHNT_BASE/go

    # #
    # export PATH=$GOPATH/bin:$DHNT_BASE/bin:$PATH

    # #
    # mkdir -p $DHNT_BASE/go/bin
    # mkdir -p $DHNT_BASE/home
    # mkdir -p $DHNT_BASE/etc
}