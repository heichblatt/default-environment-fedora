# My Default Computing Setup, Fedora Edition

Currently, this is only a loose collection of scripts to install software that is not available from the distribution repositories.

## Software

| Software | Script | Note |
| --- | --- | --- |
| Vagrant | scripts/vagrant.sh | installs RPM from [website](http://www.vagrantup.com/downloads.html) |
| Sublime Text 3 | scripts/sublimetext3.sh | installs from [Tarball](http://www.sublimetext.com/3) + [Package Control](https://sublime.wbond.net/) |
| Development Packages | scripts/devel.sh | |
| Web Development Packages | scripts/webdevel.sh | |
| [Vagrant](http://www.vagrantup.com/) | scripts/vagrant | |
| [Veewee](https://github.com/jedi4ever/veewee) | scripts/veewee.sh | |

## Bootstrap a new Workstation

To run all the scripts in a subjectively prioritized order, run

```bash
./bootstrap.sh
```

## Test

To test if changes will actually work, install [Docker](https://www.docker.io/) use @./Dockerfile@.

```bash
docker build .
```