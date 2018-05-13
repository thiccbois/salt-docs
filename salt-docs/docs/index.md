# Thiccbois documentation for the "{{ customer.name }}" saltstack

Hi there, thanks for inviting us to help in the modernisation of your infrastructure.

What follows is a brief introduction to the basics of using salt from your salt master at "{{ salt.master }}".

For best results, ssh into your salt-master and review the "[Getting Started](getting-started.md)" section.

```
ssh {{ salt.master }} -vvv
```

For a high level overview of the core salt concepts head over to "[Overview](overview.md)" section.

## Reference

1. Read about Salt (version: {{ salt.version }}) [SaltStack docs](https://docs.saltstack.com/en/latest/)
2. A list of Salt Formulas [Salt Formulas](https://github.com/saltstack-formulas)
3. Templating with Cookiecutter [CookieCutter](https://github.com/audreyr/cookiecutter)