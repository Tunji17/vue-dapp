#!/usr/bin/env bash
rm -rf truffledrizzle/vapp/node_modules
npm cache verify
docker run --rm -v "$(pwd)/truffledrizzle/vapp":/data -w /data -it node:10 bash