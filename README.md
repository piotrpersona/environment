# Developer environment [![Build Status](https://travis-ci.org/piotrpersona/environment.svg?branch=master)](https://travis-ci.org/piotrpersona/environment)

The aim of this project is to automate installation and configuration of my developer environment.
When it comes to changing a workspace it is common to install
all the necessary tools by hand.
What if you forget about something? What if you lose your environment?
The best way to eliminate this issues is to store your
whole environment in a cloud and automate process of installation and configuration.

## Install

Install environment packages

```bash
git clone https://github.com/piotrpersona/environment.git && ./environment/install.sh
```


```bash
./install.sh
```

```bash
ansible-playbook ansible/environment.yml
```


## Supported Operating Systems

* Mac OS X
