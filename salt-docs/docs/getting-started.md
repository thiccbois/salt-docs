# Getting Started

*we are working on a helper tool called [salt-primer](https://github.com/thiccbois/saltprimer) to make this process simpler*

Create the following tree structure.


```
mkdir -p ./{{ salt.project }}-saltstack/formulas
```

then go ahead and:

```
cd {{ salt.project }}-saltstack
# pillar
git clone {{ salt.git.pillar }} pillar
# profiles
git clone {{ salt.git.profiles }} profiles
# formulas{% for application in salt.git.formulas %}
git clone {{ application.repo }} formula/{{ application.name }}{% endfor %}
```

**Dont have access?** [Contact one of us](contact.md)


Now your tree should look like

```
./{{ salt.project }}-saltstack
├── formulas{% for application in salt.git.formulas %}
│   └── {{ application.name }}{% endfor %}
├── pillar
│   ├── LICENSE
│   ├── README.md
│   ├── base.sls
│   ├── top.sls
└── profiles
    ├── LICENSE
    ├── README.md
    ├── base.sls
    ├── saltmaster.sls
    ├── top.sls
```

#### Great, so now you can go about:

1. creating folder structure to reflect your application/infrastructure relationship
2. map hostnames to the folder structure in the `tops.sls` for both `pillar` and `profiles`

*NB* remember to `git add -p` `git commit -m""` and `git push origin master` and wait a few seconds for your changes to be refleced on salt-master "`{{ salt.master }}`"

### Application to Infrastructure relationships

I have an app
That app, can run in QA and Production (dev and staging too, but for this example well stick with QA and PRD)
Obviously in QA we have different database connection settings than in PRD? right? right?
I want to reflect that in predictable manner, based on my hostnames

In its most basic form:

`qa-my_app-01.{{ salt.fqdn }}`

*notice the hostname is broken down into*

`<env>-<application>-<instance_id>.{{ salt.fqdn }}`

Thus the pillar structure, reflects the hostname structure:

`qa-my_app-*.{{ salt.fqdn }}` and `prd-my_app-*.{{ salt.fqdn }}`

would have a folder structure like so:

```
./{{ salt.project }}-saltstack
├── pillar
│   └── qa
│       └── my_app
│           └── init.sls
│   └── prd
│       └── my_app
│           └── init.sls
└── profiles
    └── top.sls
```

**NB** of course you could also have `pillar/qa/my_app/01/init.sls` and `pillar/qa/my_app/02/init.sls` but this kind of granularity not usually necessary and very rarely recommended.

**NB** yes, you can group the folders by `<application>-<env>-<instance>` if you like. We are simply proposing a structure that we know to work best.

#### Profile - the applications you want installed

In the `profiles.top.sls` we would include application formula for my_app:

```
base:
  'prd|qa-my_app-*.{{ salt.fqdn }}':  # notice the `*` wildcard 
                                  #   and that both prd AND qa will have this formula
    - {{ salt.project }}                     # this is the "name" of the formulas/{{ salt.project }}-formula/{{ salt.project }} folder 
                                  #   and usually also the name in this formulas config/defaults.sls
```

#### Pillar - the settings for the applications

in the `pillar.qa.my_app.init.sls` we would have the config settings for qa:

``` QA
{{ salt.project }}:
  aws:
    region: eu-west-1
    aws_access_key: ************
    aws_secret_access_key: ************************************

  docker:
    name: {{ salt.project }}-app
    image: dockerhub.com/{{ salt.project }}:latest   # can set to latest in QA
    tag: latest
    ports:
      - "8000:8000"

  app:
    - DEBUG: True
    - PROJECT_ENVIRONMENT: qa
    .... other settings
```

And therefore in the production environment: `pillar.prd.my_app.init.sls`

``` PRD
{{ salt.project }}:
  aws:
    region: eu-central-2
    aws_access_key: ************
    aws_secret_access_key: ************************************

  docker:
    name: {{ salt.project }}-app
    image: dockerhub.com/{{ salt.project }}:63af902    # because we want to be explicit about our container tag in production
    tag: latest
    ports:
      - "8001:8000"

  app:
    - DEBUG: False
    - PROJECT_ENVIRONMENT: production
    .... other settings
```


## Q & A

### What are `profiles`?
*The applications you want running on your infrastructure that reflect your infrastructure composition with folders*

`Profiles` or "`states`" are the applications and "things" that you want installed on machine instances


### What are `pillar`?
*The config settings for your application instances that reflect your infrastructure composition with folders*

`Pillars` are the config settings for your applications.
They can be thought of as config instances, as in sometimes you have an application that you wan configured differently on different machines, by using folder structures you can use the same settings structure, but with different values


### What are `formulas`?
*Application packages with default config and file templates*

Formulas are a way of packaging `pillar` and `profiles` so that they will install an application and allow it to be configured within your infrastructure.


### Why do we have a `pillar` and a `profiles` repo?
*Why not just combine them?*

Salt seperates pillar and profiles at the file level thus we need 2 seperate repos to keep things simple.
However, there are other security benefits too, you may not want your pillar exposed to anyone except some ops
but you may want to expose the applications installed on machines for your developers. [12factor app](https://12factor.net)

### What is the `tops.sls`?
*In both `pillar` AND `profiles`*

