# The Salt Master

## Primary Paths and Structure

### /etc/salt - Salt Primary

```tree
/etc/salt
|-- bootstrap
|-- cloud
|-- cloud.conf.d
|-- cloud.deploy.d
|   `-- bootstrap-py3.sh                # Our bootstrap used to get a minion started
|-- cloud.maps.d
|-- cloud.profiles.d                    # cloud profiles that are used to spawn instances in regions with specifications
|   `-- {{ salt.cloud.profile.name }}   
|-- cloud.providers.d                   # aws, digital-ocean, openstack, etc
|   `-- {{ salt.project }}.conf         # configuration for that cloud
|-- gitfs_rsa                           # Gitfs
|-- gitfs_rsa_pillar                    # Gitfs
|-- gitfs_rsa_pillar.pub                # Gitfs
|-- gitfs_rsa.pub                       # Gitfs
|-- gitfs_rsa_sudoers                   # Gitfs
|-- gitfs_rsa_sudoers.pub               # Gitfs
|-- gpgkeys                             # Secret keys
|-- master
|-- master.d
|   |-- engine.conf
|   |-- f_defaults.conf
|   |-- lxc_profiles.conf
|   `-- reactor.conf
|-- minion
|-- minion.d
|   |-- beacons.conf
|   |-- engine.conf
|   |-- f_defaults.conf
|   |-- reactor.conf
|   `-- _schedule.conf
|-- minion_id
|-- pki
|   |-- cloud                           # Secret keys
|   |-- master                          # Secret keys
|   `-- minion                          # Secret keys
|-- proxy
|-- proxy.d
`-- user-data
```

### /var/log - Logs

```
sudo tail -f -n200 /var/log/salt/minion  # see whats going on in the minion
sudo tail -f -n200 /var/log/salt/master  # see whats going on in the master
```