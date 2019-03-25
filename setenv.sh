##
function set_env {
    export DHNT_BASE=$PWD/build
    export GOPATH=$DHNT_BASE/go
}

##
set_env

goos=(
darwin
linux
windows
)

TAG_NAME=$(git tag -l --contains HEAD)
if [ -z "$TAG_NAME" ]; then
    echo "HEAD not tagged"
    exit 1
fi
##