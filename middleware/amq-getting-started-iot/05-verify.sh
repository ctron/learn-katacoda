#!/usr/bin/env bash

oc -n example get messaginguser iot.consumer &>/dev/null && echo done
