FROM quay.io/justcontainers/base-alpine:v0.12.1
MAINTAINER tynor88 <tynor@hotmail.com>

# s6 environment settings
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2
ENV S6_KEEP_ENV=1

# global environment settings
ENV RCLONE_VERSION="current"
ENV RCLONE_ARCH="amd64"

# install packages
RUN \
 apk update && \
 apk add --no-cache \
 ca-certificates

# install build packages
RUN \
 apk add --no-cache --virtual=build-dependencies \
 wget \
 unzip && \
 
 cd tmp && \
 wget -q http://downloads.rclone.org/rclone-${RCLONE_VERSION}-linux-${RCLONE_ARCH}.zip && \
 unzip /tmp/rclone-${RCLONE_VERSION}-linux-${RCLONE_ARCH}.zip && \
 mv /tmp/rclone-*-linux-${RCLONE_ARCH}/rclone /usr/bin && \
 
 apk add --no-cache --repository http://nl.alpinelinux.org/alpine/edge/community \
	shadow && \
 
# cleanup
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/tmp/* \
	/var/tmp/* \
	/var/cache/apk/*

# create abc user
RUN \
	groupmod -g 1000 users && \
	useradd -u 911 -U -d /config -s /bin/false abc && \
	usermod -G users abc && \

# create some files / folders
	mkdir -p /config /app /defaults /data && \
	touch /var/lock/rclone.lock

# add local files
COPY root/ /

VOLUME ["/config"]
