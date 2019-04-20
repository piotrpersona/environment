# Developer environment [![Build Status](https://travis-ci.org/piotrpersona/environment.svg?branch=master)](https://travis-ci.org/piotrpersona/environment)

The aim of this project is to automate installation and configuration of my developer environment.
When it comes to changing a workspace it is common to install
all the necessary tools by hand.
What if you forget about something? What if you lose your environment?
The best way to eliminate this issues is to store your
whole environment in a cloud and automate process of installation and configuration.


## Supported Operating Systems

* Mac OS X
* Ubuntu
* Alpine Linux

## Dependencies

* python 2
* ansible 2.7.10 (*optional*)

## Usage

Configure environment

```bash
./setup.sh
```

```bash
./setup.sh --inventory <PATH TO INVENTORY FILE>
```

```bash
ansible-playbook ansible/install.yml -i <PATH TO INVENTORY>
```

## Example inventory

```ini
[environment]
localhost ansible_connection=local
```

## Testing

Below command will run tests on supported linux distros.

```bash
./tests/test.sh
```
