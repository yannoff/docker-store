# yannoff/gitbox

Derived from [sshbox](../sshbox) and modified for the needs of [su-git](https://github.com/yannoff/su-git) project.

## Usage

**NOTE:** _The_ `USER` _environment variable is **mandatory** to_ `gitbox` _and therefore must be set._

Optionally, a few other variables may be used to override defaults:
- `GROUP` Name of the group running the sandbox (defaults to `USER` value)
- `GID` Id of the group running the sandbox
- `UID` Id of the user running the sandbox (defaults to 1000)

**Mounted volumes & directories**
- Known hosts file _MUST_ be mounted to `/app/ssh/known_hosts`
- Private RSA key file _MUST_ be mounted to `/app/ssh/id_rsa`
- Workdir path _MUST_ be declared relatively to the git top-level dir

**NOTE:** _Docker container should be run with the host (`-h`) option set to match the host machine._

### Example

```bash
docker run --rm -h `hostname` -v "/path/to/private/key_rsa":/app/ssh/id_rsa -v "/home/user/.ssh/known_hosts":/app/ssh/known_hosts  -e USER=`whoami` gitbox <git-command>
```
