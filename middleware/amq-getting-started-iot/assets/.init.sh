#!/usr/bin/env bash

set -e

# fetch client tools

echo -n "Fetching client tools... "

curl -Ls -o /usr/local/bin/hot https://github.com/ctron/hot/releases/download/v0.3.0/hot-linux-amd64
chmod +x /usr/local/bin/hot
curl -Ls -o /tmp/hat.tar.gz https://github.com/ctron/hat/releases/download/v0.4.2/hono-admin-tool-v0.4.2-linux-64bit.tar.gz
pushd /usr/local/bin &>/dev/null
tar xzf /tmp/hat.tar.gz
popd &>/dev/null
rm -f /tmp/hat.tar.gz
chmod +x /usr/local/bin/hat

echo "done!"

echo -n "Pulling images... "
for i in {1..200}; do test -f ~/pulled && break || sleep 5; done
echo "done!"

echo -n "Waiting for AMQ Online installation... "
for i in {1..200}; do test -f ~/ready && break || sleep 5; done
echo "done!"

rm ~/pulled ~/ready

#echo -n "Wait for IoT infrastructure to be ready... "
#for i in {1..200}; do oc  && break || sleep 5; done
#echo "done!"

echo "Waiting for AMQ Online readiness... this may take a while ..." 
for i in api-server address-space-controller standard-authservice iot-mqtt-adapter; do
	echo -n "    $i ... "
	oc wait --for=condition=Available "deployment/$i" --timeout=5m &>/dev/null
	echo "ok!"
done

echo
echo "*** Infrastructure ready ***"
echo
