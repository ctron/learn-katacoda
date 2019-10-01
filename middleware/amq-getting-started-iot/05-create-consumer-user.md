While the system has automatically setup up the infrastructure
to deliver IoT communication to your newly created address space, it is
up to you how you grant access to this address space for your custom
application logic.

So we need to create a new `MessagingUser` resource, to allow access
to the IoT specific addresses in the address space named `iot`.

You can create the user simply by importing the resource from the
file `~/iot/iot-user-consumer.yaml`:

``oc create -f ~/iot/iot-user-consumer.yaml``{{execute HOST1}}
