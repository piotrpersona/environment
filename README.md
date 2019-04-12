# Developer environment [![Build Status](https://travis-ci.org/piotrpersona/environment.svg?branch=master)](https://travis-ci.org/piotrpersona/environment)

The aim of this project is to automate installation and configuration of my developer environment.
When it comes to changing a workspace it is common to install
all the necessary tools by hand.
What if you forget about something? What if you lose your environment?
The best way to eliminate this issues is to store your
whole environment in a cloud and automate process of installation and configuration.


# Supported Operating Systems

* Linux/Ubuntu
* Mac OS X (*to be done*)


# Dependencies

* python 2
* ansible 2.7.10 (*optional*)

# Usage

Configure environment

```bash
./setup.sh
```

```bash
./setup.sh --inventory <PATH TO INVENTORY FILE>
```
