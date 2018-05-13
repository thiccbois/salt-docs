# Frequently Asked Questions

*He who asks a question is a fool for five minutes; he who does not ask a question remains a fool forever.*

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

