# cloudbox_util
A utility script to provide simple aliases to various cloudbox functions.

Work in progress

```
➜ ./cb_util.sh -h
Usage:
    cb -h                  Display this help message.
    cb install <package>   Install <package>.
    cb remove <package>    Install <package>.
    cb logs  <package>     Display logs for <package>.
    cb certs renew         Force-renew all certs.
    cb certs status        Display certs status.
    cb ncdu all            opens ncdu at / with /opt/plex excluded
    cb ncdu all-with-plex  opens ncdu at /
    cb usage sync          Space used by Plex sync directory
    cb usage local         Space used by /mnt/local directory
    cb update [os]         Update local cloudbox files
    cb upgrade             Run cloudbox tag to upgrade
    cb bench               Run nench benchmark
    cb plex token          Retrieve plex token
    cb plex fix-trash      Fix plex trash
```
