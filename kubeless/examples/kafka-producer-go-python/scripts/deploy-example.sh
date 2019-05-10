#!/bin/bash

kubeless function deploy consumer \
	--runtime go1.10 \
	--handler consumer.ReadMessage \
	--from-file consumer/consumer.go \
	--dependencies consumer/Gopkg.toml

kubeless function deploy py-producer \
	--runtime python3.7 \
	--from-file producer-python/producer.py \
	--handler producer.send_message \
	--dependencies producer-python/requirements.txt

kubeless trigger kafka create call-consumer \
	--function-selector created-by=kubeless,function=consumer \
	--trigger-topic example
