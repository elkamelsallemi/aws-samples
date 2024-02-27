
##

To create a new directory named roles, enter the following commands:
```bash
cd ~
mkdir roles
cd roles
```

Create the skeleton of a new Ansible role, enter the following:

```bash
ansible-galaxy init lamp
```

To see the directory structure of the role you created, enter the following command:

```bash
tree lamp
```

Create a new file in your home directory, enter the following:

```bash
vim ~/app.yml
```

To run your playbook, enter the following command:

```bash
ansible-playbook ~/app.yml
```