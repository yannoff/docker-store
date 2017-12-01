# yannoff/sshbox

A sandbox to issue SSH commands in a self-contained & secluded environment, based on Alpine.

## Usage

The following environment variables are **mandatory** to `sshbox` and therefore must be set:
- `USER` Name of the user running the sandbox
- `KNOWN_HOSTS` Host list to be added to the RSA known hosts list, mandatory if no `known_hosts` file mounted (\*)


Optionally, a few other variables may be used to override defaults:
- `GROUP` Name of the group running the sandbox (\*)
- `GID` Id of the group running the sandbox (\*)
- `UID` Id of the user running the sandbox (\*)

- `CREATE_SSH_KEY` Flag to request for a new RSA SSH key creation inside the container. (\*) Public SSH Key will be output into container's log.
- `DAEMONIZE` Flag to keep the container running, allowing for later `docker exec` command

`(*)`: Only at first run.

**NOTE:** _Docker container should be run with the host (`-h`) option set to match the host machine._

**NOTE:** _Unless using `CREATE_SSH_KEY` flag, mounting your identity private key file to `/app/ssh/id_rsa` is **mandatory** at first run for `sshbox` to run properly._

### Examples

#### Creating a new known_hosts

```bash
docker run --rm -h `hostname` -v "/path/to/private/key_rsa":/app/ssh/id_rsa -e USER=`whoami` -e UID=1000 -e KNOWN_HOSTS=github.com sshbox <ssh-command-to-be-run>
```
#### Using host machine `known_hosts` file

```bash
docker run --rm -h `hostname` -v "/path/to/private/key_rsa":/app/ssh/id_rsa -v "/home/user/.ssh/known_hosts":/app/ssh/known_hosts  -e USER=`whoami` -e UID=1000 sshbox <ssh-command-to-be-run>
```

**NOTE:** _The file has to be mounted to `/app/ssh/known_hosts` inside the container, or it will be ignored._

#### Generating a ssh-key on-the-fly

In some situations, it can be usefull to use a one-shot SSH Key, that will be destroyed after the container stop.

```bash
docker run --rm -h `hostname` -v "/home/user/.ssh/known_hosts":/app/ssh/known_hosts -e CREATE_SSH_KEY=1  -e USER=`whoami` -e UID=1000 sshbox <ssh-command-to-be-run>
```
