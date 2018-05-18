# Profiles
*salt states*

**In salt, profiles are the "what" and pillars are the "how"**

`Profiles` are salt-states, that install "applications" like `nginx`, `rabbitmq` or event your application `{{ salt.example.app_name }}`

A state simply says:

1. this **host**, should have this **application** installed.
2. or **not**, because you can specify that a thing should NOT be there.

*The core of the Salt State system is the SLS, or SaLt State file. The SLS is a representation of the state in which a system should be in, and is set up to contain this data in a simple format. This is often called configuration management.*

For more info on states read [Saltstack docs on state](https://docs.saltstack.com/en/latest/topics/tutorials/starting_states.html)

## Including profiles

1. in `salt-profiles/tops.sls` you can include your desired state file
2. this can be a [formula](formulas.md), but it can also be a local file that has a specific state

### including profiles usually as a formula
```
{{ salt.example.profile_top }}
```

### Include ad-hoc state file

You will often want to apply a state thats not part of a formula and then can manually create a `.sls` file and included it from tops.sls or from within another state.

`salt-profiles/tops.sls`

```
'myhost.*':
  qa.aws
```

`salt-profiles/qa/aws.sls`

The aws state, will ensure that the `awscli` program is installed from pypi.

```
awscli-installed:
  pip.installed:
    - name: awscli
```

Yes, you **could** include the `aws.sls` from a another `salt-profiles/*/**/state.sls`
