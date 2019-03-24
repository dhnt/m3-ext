# m3-ext

A collection of tools in Golang

```
goreleaser init
goreleaser --snapshot --skip-publish --rm-dist

#
export GITHUB_TOKEN='YOUR_TOKEN'

git tag -a v0.0.5 -m "goreleaser"
git push origin v0.0.5

goreleaser release --skip-publish
```
