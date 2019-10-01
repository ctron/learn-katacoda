Now that we have an OpenShift project, we create a new IoT instance inside of that.

This IoT instance (called "IoT project") isolates all IoT relevant resources from each other.
A single OpenShift project may have multiple IoT projects. An IoT project also sometimes is called
an "IoT tenant".

IoT projects are OpenShift custom resources. You can create the example project by executing:

``oc create -f iot/iot-project.yaml``{{execute HOST1}}

This will start to provision the requires messaging resources, and configure the IoT infrastructure
to route traffic towards this project.

As this will also spin up a new broker instance, it may take a bit until it is ready.

You can check the state by executing:

``oc get iotproject iot``{{execute HOST1}}
