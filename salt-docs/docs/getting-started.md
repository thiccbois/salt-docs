# Getting started with salt


## Salt - whats the fuss?

Saltstack is an incredible config management and provisioning system that makes scaling systems and ensuring services are in exactly the state they should be in, as simple as possible.

The work is done mainly on the CLI, but there are web based UIs available in enterprise.

Configuration and secrets are handled via .sls (yaml) files that are hosted in git and available only to ops.

There are a number of approaches to handling secrets one of which is GPG for which salt has a custom gpg renderer https://docs.saltstack.com/en/latest/ref/renderers/all/salt.renderers.gpg.html but this topic usually only becomes a problem with large teams that have many users accessing confidential files.


## Commands

Command examples (run from salt-master - salt.example.com)

### Run a command on all machines
```
salt '*' cmd.run "uptime"
```

### Run a command on only worker machines
```
salt 'prd-worker*' cmd.run "uptime"
```

### Run a command on only staging worker machines
```
salt 'stage-worker*' cmd.run "uptime"
```

### Run state.apply on a single machine
```
salt 'stage-worker02.example.com' state.apply
```

### Create a new instance
```
salt-cloud -p worker_machine prd-worker03
```
at this point state.apply is run and the matching name `prd-worker*` would install the app configured for running as a worker, install the latest version and bring all dependencies up


### Destroy an instance
```
salt-cloud -d prd-worker03
```

### Deployment using state with docker version latest
```
salt 'stage-worker*' state.apply pillar={"my-application":{"version": "latest"}}
```

### Deployment using state with docker tag version override
```
salt 'stage-worker*' state.apply pillar={"my-application":{"version": "rusty-lime"}}
```