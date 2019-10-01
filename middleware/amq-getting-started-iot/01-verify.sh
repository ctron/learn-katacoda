#!/usr/bin/env bash

oc -n "messaging-infra" wait --timeout=0 --for=condition=Available deployment/iot-mqtt-adapter && echo done
