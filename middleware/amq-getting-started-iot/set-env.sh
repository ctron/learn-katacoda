#!/usr/bin/env bash

/usr/local/bin/launch.sh

# we need to wait for the file to appear
while [ ! -f ~/.init.sh ]; do sleep 2; done

# then run it
~/.init.sh
