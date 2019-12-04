# cloudbox_util
A utility script to provide simple aliases to various cloudbox functions.

Work in progress

## install

```
curl "https://raw.githubusercontent.com/chazlarson/cloudbox_util/master/cb.sh" > /opt/scripts/cb.sh; chmod +x /opt/scripts/cb.sh
```

## enable

One way is to add this to the end of your `.bashrc` [or `.zshrc` or whatever your shell uses]
```
alias cb='/opt/scripts/cb.sh'
```
Log out and back in, and now you can execute it by typing `cb` anywhere.

More details and an alternative is discussed here:
https://askubuntu.com/a/17537

## update

```
curl "https://raw.githubusercontent.com/chazlarson/cloudbox_util/master/cb.sh" > /opt/scripts/cb.sh; chmod +x /opt/scripts/cb.sh
```

## running
```
➜ cb -h
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
