#!/usr/bin/env bash

# pull - should come from the environment (see 11_middleware.sh)

AMQ_ONLINE_VERSION=0.29.1
AMQ_ONLINE_BASE=quay.io/enmasse/
docker pull ${AMQ_ONLINE_BASE}address-space-controller:$AMQ_ONLINE_VERSION
docker pull ${AMQ_ONLINE_BASE}agent:$AMQ_ONLINE_VERSION
docker pull ${AMQ_ONLINE_BASE}artemis:$AMQ_ONLINE_VERSION
docker pull ${AMQ_ONLINE_BASE}artemis-base:$AMQ_ONLINE_VERSION
docker pull ${AMQ_ONLINE_BASE}broker-plugin:$AMQ_ONLINE_VERSION
docker pull ${AMQ_ONLINE_BASE}console-httpd:$AMQ_ONLINE_VERSION
docker pull ${AMQ_ONLINE_BASE}console-init:$AMQ_ONLINE_VERSION
docker pull ${AMQ_ONLINE_BASE}controller-manager:$AMQ_ONLINE_VERSION
docker pull ${AMQ_ONLINE_BASE}iot-auth-service:$AMQ_ONLINE_VERSION
docker pull ${AMQ_ONLINE_BASE}iot-device-registry-file:$AMQ_ONLINE_VERSION
docker pull ${AMQ_ONLINE_BASE}iot-device-registry-infinispan:$AMQ_ONLINE_VERSION
docker pull ${AMQ_ONLINE_BASE}iot-gc:$AMQ_ONLINE_VERSION
docker pull ${AMQ_ONLINE_BASE}iot-http-adapter:$AMQ_ONLINE_VERSION
docker pull ${AMQ_ONLINE_BASE}iot-lorawan-adapter:$AMQ_ONLINE_VERSION
docker pull ${AMQ_ONLINE_BASE}iot-mqtt-adapter:$AMQ_ONLINE_VERSION
docker pull ${AMQ_ONLINE_BASE}iot-proxy-configurator:$AMQ_ONLINE_VERSION
docker pull ${AMQ_ONLINE_BASE}iot-sigfox-adapter:$AMQ_ONLINE_VERSION
docker pull ${AMQ_ONLINE_BASE}iot-tenant-service:$AMQ_ONLINE_VERSION
docker pull ${AMQ_ONLINE_BASE}java-base:$AMQ_ONLINE_VERSION
docker pull ${AMQ_ONLINE_BASE}keycloak-plugin:$AMQ_ONLINE_VERSION
docker pull ${AMQ_ONLINE_BASE}mqtt-gateway:$AMQ_ONLINE_VERSION
docker pull ${AMQ_ONLINE_BASE}mqtt-lwt:$AMQ_ONLINE_VERSION
docker pull ${AMQ_ONLINE_BASE}qdrouterd-base:$AMQ_ONLINE_VERSION
docker pull ${AMQ_ONLINE_BASE}router:$AMQ_ONLINE_VERSION
docker pull ${AMQ_ONLINE_BASE}service-broker:$AMQ_ONLINE_VERSION
docker pull ${AMQ_ONLINE_BASE}standard-controller:$AMQ_ONLINE_VERSION
docker pull ${AMQ_ONLINE_BASE}topic-forwarder:$AMQ_ONLINE_VERSION

touch ~/pulled

# vars

TYPE="enmasse"

# install pre-reqs

mkdir -p ~/iot
yum install unzip -y

# Create PVs

oc adm policy add-cluster-role-to-group sudoer system:authenticated
mkdir -p /data/pv-01 /data/pv-02 /data/pv-03 /data/pv-04 /data/pv-05 /data/pv-06 /data/pv-07 /data/pv-08 /data/pv-09 /data/pv-10
chmod 0777 /data/pv-*
chcon -t svirt_sandbox_file_t /data/pv-*
oc create -f volumes.json
rm volumes.json

# fetch & run install scripts

mkdir infra-install
pushd infra-install

case $TYPE in

	enmasse)
	curl -L https://github.com/EnMasseProject/enmasse/releases/download/0.29.1/enmasse-0.29.1.tgz -o enmasse.tar.gz
	tar --strip-components=1 -xzf enmasse.tar.gz
	sed -i 's/enmasse-infra/messaging-infra/' install/bundles/enmasse/*.yaml
	;;

	amq-online)
	curl -L https://access.redhat.com/node/4306051/423/0/15047271 -o install.zip
	unzip install.zip
	sed -i 's/amq-online-infra/messaging-infra/' install/bundles/amq-online/*.yaml
	;;

	*)
	echo "Unknown installation type: $TYPE"
	exit 1
	;;

esac

# change pull policy
sed -i 's/Always/IfNotPresent/' install/bundles/$TYPE/*.yaml

# create new project
oc new-project messaging-infra

# deploy core
oc apply -f install/bundles/$TYPE
oc set resources deployment api-server --limits=memory=256Mi --requests=memory=256Mi
oc set resources deployment address-space-controller --limits=memory=256Mi --requests=memory=256Mi

# give the API server a bit of time
sleep 30

# deploy auth service and additional examples
oc apply -f install/components/example-authservices/standard-authservice.yaml
oc apply -f install/components/example-roles
oc apply -f install/components/example-plans

# deploy IoT
oc apply -f install/preview-bundles/iot
oc set resources deployment iot-operator --limits=memory=64Mi --requests=memory=64Mi

# give all pods a bit of time
sleep 30

# reduce memory footprint of auth service
oc set resources deployment standard-authservice --limits=memory=1536Mi --requests=memory=1536Mi

popd

# create mqtt key/cert from router key/cert
oc -n default get secret router-certs -o json | jq -r '.data["tls.key"]' | base64 -d > key.pem
oc -n default get secret router-certs -o json | jq -r '.data["tls.crt"]' | base64 -d > orig-cert.pem
openssl crl2pkcs7 -nocrl -certfile orig-cert.pem | openssl pkcs7 -print_certs | grep -v issuer | grep -v subject | csplit -f cert- - '/-----BEGIN CERTIFICATE-----/' '{*}'
#curl -Ls -o root.pem https://letsencrypt.org/certs/trustid-x3-root.pem.txt
cat cert-01 cert-02 > cert.pem
oc -n "messaging-infra" create secret tls iot-mqtt-adapter-tls --key key.pem --cert cert.pem
rm cert-* cert.pem key.pem orig-cert.pem

# create IoT infrastructure
oc apply -f ~/iot/iot-config.yaml

touch ~/ready
