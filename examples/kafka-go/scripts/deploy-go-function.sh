#!/bin/bash

kubeless function deploy get-hello \
	--runtime go1.10 \
	--handler helloget.Hello \
	--from-file hello.go \
	--dependencies Gopkg.toml
