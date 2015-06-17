Firewall
=========

The Firewall role is used to enable/disable firewall services and ports. Currently, only supports **firewalld** and is meant to be used as a dependency in other roles.

Role Variables
--------------

firewall_services: **The service name to enable**
firewall_ports: **The port to enable**

Example Usage
----------------

Example of this role being used in another role as a dependency:

      dependencies:
         - { role: firewall, firewall_service: http }
         - { role: firewall, firewall_port: 50000/tcp }

Author Information
------------------
Chris Argeros (chris(-AT-)argeros.org)
