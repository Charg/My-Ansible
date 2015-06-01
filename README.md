# My-Ansible

## Cloud
`play_cloud`: This playbook is used to provision a CoreOS cluster on multiple cloud providers. Currently supports **Rackspace**.

### Usage:
Provision **two** rackspace servers and a **single** DigitalOcean server using ansible.
ansible-playbook --ask-vault-pass -e "rax=true,rax_instance_count=2,digi=true,digi_droplet_name=Hostname.domain.com" play_CloudProvision

### Variables:
You will need to provide the following private variables. Personally, I put them in `./inventory/host_vars/localhost` and secure it using git-crypt.
`rax_api_key:`  
`rax_user:`
`rax_instance_name:`
`digi_api_key:`
`digi_client_id:`
`digi_droplet_name:`
