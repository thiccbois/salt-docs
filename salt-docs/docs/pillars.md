# Pillars
*config settings - In salt pillars are the how and profiles are the what*

**Pillars are like layers in a cake, the lowest layer being the formula defaults, and the highest layer being production**

![pillars are like layers](/img/layer-cake.jpg "Pillars are like layers in a cake")

Pillars are config settings that define how your applications will run.

1. what database will your app `{{ salt.example.app_name }}` talk to?
2. what are the timeout settings
3. cache timeout
3. etc.

*The core of the Salt Pillar system is the SLS, or SaLt State file. The SLS is a representation of the state in which a system should be in, and is set up to contain this data in a simple format. This is often called configuration management.*

For more info on pillars read [Saltstack Pillar walkthrough](https://docs.saltstack.com/en/latest/topics/tutorials/pillar.html#pillar-walk-through)

## Including pillars

1. in `salt-pillars/tops.sls` you can include your desired pillar file
2. the default keys and values can usually be found in [formula](formulas.md)
3. the pillar file is a dictionary (a hash) that contains key-values that can be overriden per environment

### Including pillars
```
{{ salt.example.pillar_top }}
```

The contents of the pillar map to the defaults in the formula state you are wanting to use.

`my_application-formula/my_application/config/defaults.sls`

```
my_application:
  #
  # aws specific structure
  #
  aws:
    # elastic container registry
    ecr:
      region: null
      aws_access_key: null
      aws_secret_access_key: null

  docker:
    name: my_application
    image: null
    tag: latest
    ports:
        - 8000:8000

  #
  # Default config variables for my application
  #
  app:
    DEBUG: True
    PROJECT_ENVIRONMENT: development

```

Notice how the variables are mostly `null`, your formula should NEVER expose keys or values that are sensitive. It serves mainly to provide the structure necessary to get your application running.


### Set the pillar values in the target environment

Now we can map our hostname to an environment pillar file (remembering to **first** include the profile/formula in your profiles)

The aws state, will ensure that the `awscli` program is installed from pypi.

*salt-pillars/tops.sls*

```
'qa-my_application*'
    - qa.my_application
```

*salt-pillars/qa/my_application/init.sls*

```
my_application:
  aws:
    ecr:
      region: eu-central-1
      aws_access_key: .............
      aws_secret_access_key: .............

  docker:
    name: my_application
    image: hub.docker.com/my_application
    tag: 5d12j3
    ports:
        - 8080:8000

  app:
    DEBUG: False
    PROJECT_ENVIRONMENT: qa
```

Now, on the `qa-my_application.example.com` host I would have the complete environment defined in the formula, but with my overrident pillar config settings.

