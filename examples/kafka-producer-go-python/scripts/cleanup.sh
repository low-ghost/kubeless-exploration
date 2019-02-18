#!/bin/bash

echo 'deleting functions'
kubeless function delete consumer
kubeless function delete py-producer
echo 'deleting trigger'
kubeless trigger kafka delete call-consumer
echo 'deleting topic'
kubeless topic delete example 
