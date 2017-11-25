# yannoff/sshbox

A sandbox to issue SSH commands in a self-contained & secluded environment, based on Alpine.

## Usage

The following environment variables are **mandatory** to `sshbox` and therefore must be set:
- `USER` Name of the user running the sandbox
- `UID` Id of the user running the sandbox (\*)
- `KNOWN_HOST` Host to be added to the RSA known hosts list (\*)


Optionally, a few other variables may be used to override defaults:
- `GROUP` Name of the group running the sandbox (\*)
- `GID` Id of the group running the sandbox (\*)

`(*)`: Only at first run.

**NOTE:** _Docker container should be run with the host (`-h`) option set to match the host machine._

**NOTE:** _Mounting your identity private key file to `/app/ssh/id_rsa` is **mandatory** at first run for `sshbox` to run properly._

### Example standalone

```bash
docker run --rm -h `hostname` -v "/path/to/private/key_rsa":/app/ssh/id_rsa -e USER=`whoami` -e UID=1000 -e KNOWN_HOST=github.com sshbox <ssh-command-to-be-run>
```
