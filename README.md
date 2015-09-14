# My Default Computing Setup, Fedora Edition

Currently, this is only a couple [Ansible](http://www.ansible.com/) playbooks.

## Bootstrap a new Workstation

Run the main playbook.

```bash
ansible-playbook -vv -i "localhost," --ask-sudo-pass ./provision.yml
```

## Test

To test if changes will actually work, install [Docker](https://www.docker.io/) and

```bash
make test
```
