Openstack user and administration tools/scripts
===============================================

Tools and scripts utilities for openstack administration

Introduction
------------

Some of the scripts need the Openstack environment variables
setup, for the `admin` user

```
export OS_PROJECT_DOMAIN_NAME=default
export OS_USER_DOMAIN_NAME=default
export OS_PROJECT_NAME=admin
export OS_USERNAME=admin
export OS_PASSWORD=XXX
export OS_AUTH_URL=https://controller.example.org:35357/v3
export OS_IDENTITY_API_VERSION=3
export OS_IMAGE_API_VERSION=2
```

Clean unused floating IPs
-------------------------

This script removes unused public IPs, returns them to the pool

```
./unused-pubIPs.sh
```

Add Openstack users
-------------------

Add a user to openstack, set the following variables inside the scripts

```
PROJ="PROJ_NAME"
USER="USERNAME"
DESC="User Description"
UPASS="Change Password"
EMAIL="user email
```

```
./useradd-os.sh
```


License
-------

GNU GENERAL PUBLIC LICENSE Version 3

Author Information
------------------

Mario David: mariojmdavid@gmail.com

LIP and Indigo
