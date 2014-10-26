# My Default Computing Setup, Fedora Edition

Currently, this is only a loose collection of scripts to install software that is not available from the distribution repositories.

## Bootstrap a new Workstation

To run all the scripts in a subjectively prioritized order, run

```bash
sudo make
```

## Test

To test if changes will actually work, install [Docker](https://www.docker.io/) and use the Dockerfile.

```bash
docker build .
```
or
```bash
make test
```
