docker pull registry.access.redhat.com/jboss-eap-7/eap70-openshift
docker pull registry.access.redhat.com/jboss-fuse-6/fis-java-openshift
docker pull registry.access.redhat.com/jboss-webserver-3/webserver31-tomcat8-openshift
docker pull registry.access.redhat.com/jboss-amq-6/amq63-openshift
docker pull registry.access.redhat.com/redhat-sso-7/sso71-openshift
docker pull registry.access.redhat.com/rhoar-nodejs/nodejs-8

# OpenJDK
docker pull registry.access.redhat.com/redhat-openjdk-18/openjdk18-openshift
docker pull fabric8/java-jboss-openjdk8-jdk:1.3.1

# Red Hat JBoss DataGrid
docker pull registry.access.redhat.com/jboss-datagrid-7/datagrid71-openshift
docker pull registry.access.redhat.com/jboss-datagrid-7/datagrid71-client-openshift

# Red Hat JBoss DataVirt
docker pull registry.access.redhat.com/jboss-datavirt-6/datavirt63-openshift
docker pull registry.access.redhat.com/jboss-datavirt-6/datavirt63-driver-openshift

# Red Hat JBoss BRMS
docker pull registry.access.redhat.com/jboss-decisionserver-6/decisionserver64-openshift

# Red Hat JBoss BPM Suite
docker pull registry.access.redhat.com/jboss-processserver-6/processserver64-openshift

# Red Hat Decision Manager
docker pull registry.access.redhat.com/rhdm-7/rhdm70-decisioncentral-openshift:1.1
docker pull registry.access.redhat.com/rhdm-7/rhdm70-kieserver-openshift:1.1
docker pull registry.access.redhat.com/rhdm-7/rhdm72-decisioncentral-openshift:1.1
docker pull registry.access.redhat.com/rhdm-7/rhdm72-kieserver-openshift:1.1

# Red Hat Process Automation Manager
docker pull registry.access.redhat.com/rhpam-7/rhpam72-businesscentral-openshift:1.1
docker pull registry.access.redhat.com/rhpam-7/rhpam72-kieserver-openshift:1.1

# Strimzi & Debezium
STRIMZI_VERSION=0.2
DEBEZIUM_VERSION=0.7
docker pull strimzi/zookeeper:$STRIMZI_VERSION
docker pull strimzi/kafka-statefulsets:$STRIMZI_VERSION
docker pull strimzi/kafka-connect-s2i:$STRIMZI_VERSION
docker pull strimzi/cluster-controller:$STRIMZI_VERSION
docker pull strimzi/topic-controller:$STRIMZI_VERSION
docker pull debezium/example-mysql:$DEBEZIUM_VERSION

# AMQ Online

yum install unzip -y
#AMQ_ONLINE_VERSION=1.2
#AMQ_ONLINE_BASE=registry.access.redhat.com/amq7/amq-online-1-
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

# Requires RHEL subscription
# docker pull registry.access.redhat.com/jboss-fuse-6/fis-karaf-openshift

curl -k -L -o /opt/jboss-image-streams.json https://raw.githubusercontent.com/redhat-middleware-hackathon/openshift-files/master/jboss-image-streams.json
