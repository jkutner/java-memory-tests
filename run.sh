#!/bin/bash

iid=${1}
pid=${2}

old_cp=$(pbpaste)

ion-client ssh $iid cat /proc/$pid/smaps | pbcopy

pbpaste > smaps.txt

ruby parse.rb

cp smaps.txt smaps-${iid}-${pid}.txt

echo "$old_cp" | pbcopy
