# Getting started with saltstack



## Example Commands

Command examples (run from salt-master - salt.example.com)

#### Run a command on all machines
```
salt '*' cmd.run "uptime"
```

#### Run a command on only worker machines
```
salt 'prd-worker*' cmd.run "uptime"
```

#### Run a command on only staging worker machines
```
salt 'stage-worker*' cmd.run "uptime"
```

#### Run state.apply on a single machine
```
salt 'stage-worker02.example.com' state.apply
```

#### Create a new worker instance

Once you have created a worker profile you are then able to spawn instances of it.

```
salt-cloud -p worker_machine prd-worker03
```
at this point state.apply is run and the matching name `prd-worker*` would install the app configured for running as a worker, install the latest version and bring all dependencies up


#### Destroy an instance
```
salt-cloud -d prd-worker03
```

#### Deployment using state with docker version latest
```
salt 'stage-worker*' state.apply pillar={"my-application":{"version": "latest"}}
```

#### Deployment using state with docker tag version override
```
salt 'stage-worker*' state.apply pillar={"my-application":{"version": "rusty-lime"}}
```