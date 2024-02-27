
This playbook consists of one task that installs four packages.

The task uses Ansible's built-in apt module to interact with the apt package manager which is used by the Ubuntu Linux operating system. To learn more about the apt Ansible module, see the ansible.builtin.apt – Manages apt-packages page __https://docs.ansible.com/ansible/latest/collections/ansible/builtin/apt_module.html#ansible-collections-ansible-builtin-apt-module__ of the Ansible documentation.

Also, configuration the Apache webserver to enable a HTTPS site.

```YAML
---  
- hosts: localhost
  gather_facts: false
  connection: local
  become: yes

  vars:
    packages:
      - apache2
      - mysql-server
      - mysql-common
      - mysql-client
    services:
      - apache2
      - mysql

  tasks:
    - name: Install our packages
      apt:
        name: "{{ packages }}"
        state: present
    - name: Confirm services are running
      service:
        name: "{{ item }}"
        state: started
      with_items: "{{ services }}"
    - name: Enable Apache2 modssl
      shell: a2enmod ssl
    - name: Enable Apache2 Default HTTPS site
      shell: a2ensite default-ssl
    - name: Restart Apache
      service:
        name: apache2
        state: restarted


```

To run your Ansible playbook, enter the following command:

```bash
ansible-playbook lamp.yml
```

To confirm that the packages have been installed, re-run the dpkg command:

```bash
dpkg -l apache2 mysql-server

```
