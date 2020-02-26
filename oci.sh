#!/bin/sh
docker run \
  --interactive --tty --rm \
  --volume "$PWD":/oracle-cloud \
  --workdir /oracle-cloud \
  brianxphan/oracle-cloud-tools:2018.01 "$@"