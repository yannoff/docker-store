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

`(*)`: Only at first run.

**NOTE:** _Docker container should be run with the host (`-h`) option set to match the host machine._

**NOTE:** _Mounting your identity private key file to `/app/ssh/id_rsa` is **mandatory** at first run for `sshbox` to run properly._

### Example - Creating a new known_hosts

```bash
docker run --rm -h `hostname` -v "/path/to/private/key_rsa":/app/ssh/id_rsa -e USER=`whoami` -e UID=1000 -e KNOWN_HOSTS=github.com sshbox <ssh-command-to-be-run>
```
### Example - Using host machine `known_hosts` file

```bash
docker run --rm -h `hostname` -v "/path/to/private/key_rsa":/app/ssh/id_rsa -v "/home/user/.ssh/known_hosts":/app/ssh/known_hosts  -e USER=`whoami` -e UID=1000 sshbox <ssh-command-to-be-run>
```

**NOTE:** _The file has to be mounted to `/app/ssh/known_hosts` inside the container, or it will be ignored._
