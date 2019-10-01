Creating an IoT project triggered the creation of a few additional
resources in the background.

First, a new address space got created. You see this by executing the following command:

``oc get addressspace``{{execute HOST1}}

This will show you the new address space `iot`, which was created for the IoT project.

Executing:

``oc get addresses``{{execute HOST1}}

will show the addresses for telemetry data, events and command and control.

And finally there is the user which is used to stream data from the IoT infrastructure
to the newly created address space. You can get all users by executing:

``oc get messaginguser``{{execute HOST1}}
