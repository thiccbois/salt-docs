# Overview of salt

Saltstack is an incredible config management and provisioning system that makes scaling systems and ensuring services are in exactly the state they should be in, as simple as possible.


### UI or CLI
The work is done mainly on the CLI, but there are web based UIs available in enterprise.


### Event Bus
Salt is an event Bus system, this means it can send and receive events.

#### Reactors - processing events
Reactors are used to process events for example; on machine create, a reactor is created to do the `state.apply`, and if you machine has a host that matches in the tops.sls it will get all the goodness required for that host.

#### Orchestrate - complex scenarios
Orchestrate runners are for running multi step proceses

### Salt Cloud - create, destroy and run on single instances or groups of machines
Salt integrates with all large cloud providers. You can use salt-cloud -p|-d to create/destroy instances of machines

### Salt Cloud-Maps - create, destroy and run on single instances or groups of machines
Cloud-maps allow you to do things to groups of instances; for example. 3 instances of type `app` in `availability-region A` and 2 instances in `AZ B` are simple with cloud-map

### Secrets
Configuration and secrets are handled via .sls (yaml) files that are hosted in git and available only to ops.


### Super-Secret secrets
There are a number of approaches to handling secrets one of which is GPG for which salt has a custom gpg renderer ["Salt GPG Renderer"](https://docs.saltstack.com/en/latest/ref/renderers/all/salt.renderers.gpg.html) but this topic usually only becomes a problem with large teams that have many users accessing confidential files.


### Debugging salt

Sometimes your formulas or pillars will error out, in these cases the error should be clearly indicated in the state message.
However, sometimes you will need to:

```
sudo tail -n300 /var/log/salt/minion
# or 
sudo tail -n300 /var/log/salt/master
```

![salt overview](/img/salt-layout.png "Logo Title Text 1")