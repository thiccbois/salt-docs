# Overview of salt

Saltstack is an incredible config management and provisioning system that makes scaling systems and ensuring services are in exactly the state they should be in, as simple as possible.

The work is done mainly on the CLI, but there are web based UIs available in enterprise.

Configuration and secrets are handled via .sls (yaml) files that are hosted in git and available only to ops.

There are a number of approaches to handling secrets one of which is GPG for which salt has a custom gpg renderer https://docs.saltstack.com/en/latest/ref/renderers/all/salt.renderers.gpg.html but this topic usually only becomes a problem with large teams that have many users accessing confidential files.


![alt text](/img/salt-layout.png "Logo Title Text 1")
