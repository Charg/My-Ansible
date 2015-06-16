TaskWarrior Server
=========

This role deploys a (TaskWarrior)[http://taskwarrior.org/] server.

Role Variables
--------------

- task_port: **Port to use**
- task_user: **User to run TASKD as**
- task_data: **Location of TASKD data directory**
- task_exe:  **Location of taskd executable**
- task_users: **List of users and their org**

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: taskserver, port: 42000 }

License
-------

BSD

Author Information
------------------

Chris Argeros (chris(-AT-)argeros.org)
