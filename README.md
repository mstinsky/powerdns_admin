
# powerdns_admin

[![Build Status](https://travis-ci.org/mstinsky/powerdns_admin.svg?branch=master)](https://travis-ci.org/mstinsky/powerdns_admin)

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with powerdns_admin](#setup)
    * [Setup requirements](#setup-requirements)
    * [Beginning with powerdns_admin](#beginning-with-powerdns_admin)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Description

The powerdns_admin module installs, configures and manages the powerdns_admin interface as a gunicorn service with systemd.

## Setup

### Setup Requirements

The module depends on the following other modules:
* puppetlabs-mysql
* puppetlabs-vcsrepo
* puppetlabs-stdlib
* camptocamp-systemd
* stankevich-python

### Beginning with powerdns_admin

To install the PowerDNS-Admin and let the module manage the installation and configuration of the needed databases:

```
  class  { 'powerdns_admin':
    db_root_password => 'strongpassword'
    db_password      => 'strongpassword',
    pdns_api_key     => 'my_pdns_api_key',
  }
```

## Usage

All interaction with the module happens with the main class powerdns_admin

## Reference

Implement puppet strings to create github page.

## Limitations

This module is only tested on Debian9 for now.
