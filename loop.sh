#!/bin/bash

while :; do ./run.sh $@ && echo "" && echo "sleeping... $(date)" && echo ""; sleep 90; done
