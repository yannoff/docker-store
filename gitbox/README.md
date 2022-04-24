# yannoff/gitbox

Derived from [sshbox](../sshbox) and modified for the needs of [su-git](https://github.com/yannoff/su-git) project.

## Usage

**NOTE:** _The_ `USER` _environment variable is **mandatory**, it has to match the user running the docker command._

Additionally, a few other variables may be used to override defaults:

Variable | Description | Default
---|---|---
`ID` | Id of the user running the sandbox | `1000`
`GID` | Id of the group running the sandbox | `$ID`
`GROUP` | Name of the group running the sandbox | `$USER`
`SSH_HOME` | Alternative directory for ssh files | `/app/ssh`
`IDENTITY_FILE` | Alternative SSH identity file | `${SSH_HOME}/id_rsa`

### Example

```bash
docker run --rm \
    -h `hostname` \
    -w /sources \
    -v $PWD:/sources \
    -v "/path/to/private/key_rsa":/app/ssh/id_rsa \
    -v "/home/user/.ssh/known_hosts":/app/ssh/known_hosts \
    -e USER=`whoami` \
    gitbox <git-command>
```

## Mounted volumes & directories

- Known hosts file **MUST** be mounted to `${SSH_HOME}/known_hosts`
- Private RSA key file **MUST** be mounted to `${SSH_HOME}/id_rsa`
- Workdir path **MUST** match the git top-level directory mount point
