
The first step is to deploy the infrastructure.

However, actually deploying the seems rather boring. So this tutorial will
do it for you. Actually, it is running while you are reading this.

Since the deployment of the infrastructure takes a bit of time (several minutes),
the following sections will explain what is currently happening.

When the process is complete, you should see the following message in the right hand side
terminal window:

    *** Infrastructure ready ***

Once the message is displayed, you can move on to the next step.

## Infrastructure deployment

First the generic messaging infrastructure is deployed. This includes the custom
resources like `AddressSpace`, `Address` and `MessagingUser`.

In a nutshell, an *address space* is a container for *addresses*. And a *messaging user*
defines who and how you may interact with those addresses. An "address" is a messaging
resource, which can be used to exchange messages between producers and consumers.

## Address characteristics

Addresses may have different characteristics. In general the system supports
volatile and persistent messaging. With persistent messaging (e.g. a "queue" on a "broker")
you have the benefit that a message will be stored in case there is currently no consumer available.
With volatile messaging, if there is currently not consumer ready to receive, the message will
not be delivered. This makes sense for some use cases, were the message is only relevant
at the current point in time. But it also is cheaper from a resource perspective, since volatile
messaging doesn't require a broker, and thus less resources and no storage.

## Sane defaults

In addition to that, the tutorial will load a simple set of roles and plans. Plans
define properties like capacity and redundancy of address spaces and addresses. Since
the resources of this tutorial are pretty limited, we are using a minimal configuration.
