help:
	grep --extended-regexp '^[a-zA-Z]+:.*#[[:space:]].*$$' $(MAKEFILE_LIST) \
	| awk 'BEGIN { FS = ":.*#[[:space:]]*" } { printf "\033[1;32m%-12s\033[0m%s\n", $$1, $$2 }'

.SILENT:

setup: # docker pull jenkins + remove previous container and volume
	./setup.sh

install: # create docker image with jenkins + plugins
	./install.sh