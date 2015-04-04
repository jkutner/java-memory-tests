#!/bin/bash

while :; do ./run.sh $@ && echo "" && echo "sleeping... $(date)" && echo ""; sleep 60; done
