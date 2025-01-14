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
* 1Fichier
* Akamai Netstorage
* Alibaba Cloud (Aliyun) Object Storage System (OSS)
* Amazon S3
* Backblaze B2
* Box
* Ceph
* China Mobile Ecloud Elastic Object Storage (EOS)
* Arvan Cloud Object Storage (AOS)
* Citrix ShareFile
* Cloudflare R2
* Cloudinary
* DigitalOcean Spaces
* Digi Storage
* Dreamhost
* Dropbox
* Enterprise File Fabric
* Fastmail Files
* Files.com
* FTP
* Gofile
* Google Cloud Storage
* Google Drive
* Google Photos
* HDFS
* Hetzner Storage Box
* HiDrive
* HTTP
* iCloud Drive
* ImageKit
* Internet Archive
* Jottacloud
* IBM COS S3
* IDrive e2
* IONOS Cloud
* Koofr
* Leviia Object Storage
* Liara Object Storage
* Linkbox
* Linode Object Storage
* Magalu
* Mail.ru Cloud
* Memset Memstore
* Mega
* Memory
* Microsoft Azure Blob Storage
* Microsoft Azure Files Storage
* Microsoft OneDrive
* Minio
* Nextcloud
* OVH
* Blomp Cloud Storage
* OpenDrive
* OpenStack Swift
* Oracle Cloud Storage Swift
* Oracle Object Storage
* Outscale
* ownCloud
* pCloud
* Petabox
* PikPak
* Pixeldrain
* premiumize.me
* put.io
* Proton Drive
* QingStor
* Qiniu Cloud Object Storage (Kodo)
* Quatrix by Maytech
* Rackspace Cloud Files
* rsync.net
* Scaleway
* Seafile
* Seagate Lyve Cloud
* SeaweedFS
* Selectel
* SFTP
* Sia
* SMB / CIFS
* StackPath
* Storj
* Synology
* SugarSync
* Tencent Cloud Object Storage (COS)
* Uloz.to
* Uptobox
* Wasabi
* WebDAV
* Yandex Disk
* Zoho WorkDrive
* The local filesystem

**Features**
* Transfers
  * MD5, SHA1 hashes are checked at all times for file integrity
  * Timestamps are preserved on files
  * Operations can be restarted at any time
  * Can be to and from network, e.g. two different cloud providers
  * Can use multi-threaded downloads to local disk
* Copy new or changed files to cloud storage
* Sync (one way) to make a directory identical
* Bisync (two way) to keep two directories in sync bidirectionally
* Move files to cloud storage deleting the local after verification
* Check hashes and for missing/extra files
* Mount your cloud storage as a network disk
* Serve local or remote files over HTTP/WebDav/FTP/SFTP/DLNA
* Experimental Web based GUI

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

+ **2024/01/12:**
  * Updated to latest Rclone(v1.38) and s6-overlay(v3.2.0.2)
+ **2017/10/15:**
  * Update to latest Rclone (v1.38)
+ **2017/01/25:**
  * Initial release
