# Formulas

*The building blocks of your application infrastructure*

A formula is a way of composing a set of profiles and pillars (applications and their configuration) that can be bundled and used by salt.

Our formulas follow the following pattern:

```
{{ salt.project }}-formula
├── CHANGELOG.md
├── FORMULA
├── Gemfile
├── Gemfile.lock
├── Makefile
├── README.md
├── pillar.example
├── reports
├── requirements.txt
├── scantrust
│   ├── config
│   │   └── defaults.yaml   # default development settings. NEVER put production settings in your formula. Production goes in the prd pillars.
│   ├── init.sls            # salt will always load this file first, and its here that you inject dependencies and states.
│   └── map.jinja           # this file is where you assemble complicated values that you need in your base project.
└── tests
    ├── README.md
    └── integration
        └── default
            └── testinfra
                └── test_{{ salt.project }}.py
```

## Create a new Formula

We use [CookieCutter](https://github.com/audreyr/cookiecutter) which is a tool that allows you to create template layouts

```
pip install cookiecutter
```

Use cookiecutter to base your new application formula off of our base formula.
```
cookiecutter https://github.com/thiccbois/salt-formula-cookiecutter
```

## Once your formula is complete

1. include it in your salt project

```
@todo:stefan
```

2. associate it with a host in the `profile/tops.sls` 
3. in `pillars/tops.sls` associate a path to a new pillar i.e. `pillars/path/to/{{ salt.example.app_name }}` with a hostname
4. then you can `salt '{{ salt.example.instances[0] }}' state.apply` and your formula should work.. or you can start debugging
