# Getting Started


Create the following tree structure.

*we are working on a helper tool called [salt-primer](https://github.com/thiccbois/saltprimer) to make this process simpler*


```
mkdir -p ./{{ salt.project }}-saltstack/formulas

# gives us

./{{ salt.project }}-saltstack
├── formulas
```

then

```
cd {{ salt.project }}-saltstack
# pillar
git clone {{ salt.git.pillar }} pillar
# profiles
git clone {{ salt.git.profiles }} profiles
# formulas
{% for application in salt.git.formulas %}git clone {{ application.repo }} formula/{{ application.name }}
{% endfor %}
```

Now your tree should look like

```
./{{ salt.project }}-saltstack
├── formulas
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

## Q & A

#### Why do we have a `pillar` and a `profiles` repo
*Why not just combine them?*

Salt seperates pillars and profiles at the file level thus we need 2 seperate repos to keep things simple.
However, there are other security benefits too, you may not want your pillars exposed to anyone except some ops
but you may want to expose the applications installed on machines for your developers. [12factor app](https://12factor.net)

#### What is the `tops.sls`?
*In both `pillar` AND `profiles`*

