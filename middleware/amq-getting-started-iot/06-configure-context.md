As the IoT project is created now, the next step is to register a new device.

For managing devices, we will use the tool `hat` (<u>H</u>ono <u>A</u>dmin <u>T</u>ool).
This is a small command line tool, which only execute HTTP requests with the
*device registry*. So technically you could also use a tool like `curl` to achieve
the same.

As a first step, we need to configure the `hat` tool with the endpoint of the device
registry. This is similar to `oc login`:

``hat context create example https://device-registry-messaging-infra.[[HOST_SUBDOMAIN]]-[[KATACODA_HOST]].environments.katacoda.com/ --default-tenant example.iot``{{execute HOST1}}
