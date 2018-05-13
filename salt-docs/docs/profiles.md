# Profiles
*salt states*

**In salt, profiles are the what and pillars are the how**

`Profiles` are salt-states, that install "applications" like `nginx`, `rabbitmq` or event your application `{{ salt.example.app_name }}`

A state simply says that "this host, should have this application installed (or not, because you can specify that a thing should NOT be there)"