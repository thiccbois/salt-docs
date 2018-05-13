# Salt Cloud
*salts way of letting you create infrastructure*

## Cloud-Map Profiles

The cloud profiles are ways of specify an ami and a region as well as which salt bootstrap script to use when booting up.

These are profiles stored at `{{ salt.cloud.profile.path }}` and currently look like:

```
{{ salt.cloud.profile.data }}
```

### Create one or more instances from a profile

1. determine in which subnet the instance should be2

```
sudo salt-cloud -p example_api_az_a {{ salt.example.instances[0] }}
```

```
sudo salt-cloud -p example_api_az_c {% for instance in salt.example.instances %}{{ instance }} {% endfor %}
```

**NB** the username is `ubuntu` above, however we usually disable this user and prefer to take ops usernames and id_rsa.pub keys as access users.



### Delete one or more instance

```
sudo salt-cloud -d {{ salt.example.instances[0] }}
```

```
sudo salt-cloud -d {% for instance in salt.example.instances %}{{ instance }} {% endfor %}
```


## Cloud Maps
*salts way of letting you spawn control and delete infrastructure across avaiability zones and regions*