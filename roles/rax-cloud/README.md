RAX-CLOUD
=========

The **RAX-CLOUD** role is used to provision and manage rackspace instances. The playbook utilizes variables to control its workflow. 

**Provision**:
In order to **provision** a new rax instance the **rax_provision** variable needs to be **true**. This variable is what triggers the provision tasks to run. Next, you need to choose whether this will be a regular server instance or a CoreOS instance. This is done by setting either the **rax_server** or **rax_core** variable to **True**. Last, you can choose to spin up multiple instances or a single instance. This is controlled by the **rax_instance_count** variable.

Provision multiple server instances:
- rax_provision
- rax_server
- rax_instance_count

**Manage**:
TODO

Requirements
------------

Relies on the pyrax python module.

> pip install pyrax  

Variables
--------------

Defaults:
- rax_instance_flavor: 'general1-1' #1GB General Purpose
- rax_instance_region: 'IAD'        #Northern Virginia

Required:
- rax_api_key
- rax_user
- rax_instance_name

Custom:
- rax_instance_count
- rax_instance_group

Other:
- rax_server
- rax_core
- rax_provision
- rax_manage

Example Playbook
----------------

    - hosts: localhost
      gather_facts: False
      roles:
         - { role: rax-cloud }

Example Runs
----------------
Provision a single rax instance:
> ansible-playbook -e 'rax_server: True, rax_provision: True, rax_instance_name: "RadServer", rax_user: "MyUsername", rax_api_key: "12345..."' play_cloud.yml

Provision **two** rax instances:
> ansible-playbook -e 'rax_server: True, rax_provision: True, rax_instance_count: 2,rax_instance_group: "DEFAULT", rax_instance_name: "RadServers", rax_user: "MyUsername", rax_api_key: "12345..."' play_cloud.yml

Getting RAX variables
---------------------

It's not documented in ansible anywhere but more so implied that in order to get a list of image names and or flavors you need to use the rackspace api. I'm sure there's a document lying around somewhere that has this data already, but I wasn't unable to find it. Instead, I read through the API docs and came across the following curl commands:

You can read the API document here: [http://docs.rackspace.com/servers/api/v2/cs-gettingstarted/content/overview.html](http://docs.rackspace.com/servers/api/v2/cs-gettingstarted/content/overview.html)

**Authenticate To RS**  
> curl -s https://identity.api.rackspacecloud.com/v2.0/tokens -X 'POST' \
>      -d '{"auth":{"RAX-KSKEY:apiKeyCredentials":{"username":"user_name_here", "apiKey":"000000000000"}}}' \
>      -H "Content-Type: application/json" | python -m json.tool | grep -E 'tenantId|id'

**Export TenantID and ID**  
ID is going to be a 32bit alpha numerical value.

> export account="000000"
> export token="00000000000000000000000000000000"

**CURL image list**  
> curl -s https://dfw.servers.api.rackspacecloud.com/v2/$account/images/detail -H "X-Auth-Token: $token" | python -m json.tool

**CURL flavor list**  
>  curl -s https://dfw.servers.api.rackspacecloud.com/v2/$account/flavors -H "X-Auth-Token: $token" | python -m json.tool
