[appurl]: https://rclone.org/
[microbadger]: https://microbadger.com/images/tynor88/rclone
[dockerstore]: https://store.docker.com/community/images/tynor88/rclone
[docker-rclone-mount]: https://github.com/tynor88/docker-rclone-mount

# docker-rclone
[![Docker Layers](https://images.microbadger.com/badges/image/tynor88/rclone.svg)][microbadger]
[![Docker Pulls](https://img.shields.io/docker/pulls/tynor88/rclone.svg)][dockerstore]
[![Docker Stars](https://img.shields.io/docker/stars/tynor88/rclone.svg)][dockerstore]
[![Docker Build Status](https://img.shields.io/docker/build/tynor88/rclone.svg)][dockerstore]
[![Docker Build](https://img.shields.io/docker/automated/tynor88/rclone.svg)][dockerstore]

Docker for [Rclone][appurl] - a command line program to sync files and directories to and from various cloud services.

**Cloud Services**
* Google Drive
* Amazon S3
* Openstack Swift / Rackspace cloud files / Memset Memstore
* Dropbox
* Google Cloud Storage
* Amazon Drive
* Microsoft One Drive
* Hubic
* Backblaze B2
* Yandex Disk
* The local filesystem

**Features**

* MD5/SHA1 hashes checked at all times for file integrity
* Timestamps preserved on files
* Partial syncs supported on a whole file basis
* Copy mode to just copy new/changed files
* Sync (one way) mode to make a directory identical
* Check mode to check for file hash equality
* Can sync to and from network, eg two different cloud accounts
* Optional encryption (Crypt)
* Optional FUSE mount (rclone mount) - **See [docker-rclone-mount][docker-rclone-mount]**

## Usage

```
docker create \
  --name=Rclone \
  -e SYNC_DESTINATION=<sync destination from .rclone.conf> \
  -v </path for rclone.conf>:/config \
  -v </path for backup>:/data \
  tynor88/rclone
```

**Parameters**

* `-v /config` The path where the .rclone.conf file is
* `-v /data` The path to the data which should be backed up by Rclone
* `-e SYNC_DESTINATION` The destination that the data should be backed up to (must be the same name as specified in .rclone.conf)
* `-e RCLONE_CONFIG_PASS` If the rclone.conf is encrypted, specify the password here
* `-e SYNC_DESTINATION_SUBPATH` If the data should be backed up to a subpath on the destionation (will automaticly be created if it does not exist)
* `-e CRON_SCHEDULE` A custom cron schedule which will override the default value of: 0 * * * * (hourly)
* `-e SYNC_COMMAND` A custom rclone command which will override the default value of: rclone sync /data $SYNC_DESTINATION:/$SYNC_DESTINATION_SUBPATH


## Info

* Shell access whilst the container is running: `docker exec -it Rclone /bin/ash`
* Upgrade to the latest version: `docker restart Rclone`
* To monitor the logs of the container in realtime: `docker logs -f Rclone`

## Versions

+ **2017/10/15:**
  * Update to latest Rclone (v1.38)
+ **2017/01/25:**
  * Initial release
