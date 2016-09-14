FROM justcontainers/base-alpine
MAINTAINER tynor88 <tynor@hotmail.com>

# global environment settings
ENV RCLONE_VERSION="current"
ENV RCLONE_ARCH="amd64"

# install build packages
RUN \
 apk update && \
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
	/var/tmp/*

# create abc user
RUN \
	groupmod -g 1000 users && \
	useradd -u 911 -U -d /config -s /bin/false abc && \
	usermod -G users abc && \

# create some folders
	mkdir -p /config

# add local files
COPY root/ /

USER abc

ENTRYPOINT ["/usr/bin/rclone"]

VOLUME ["/config"]

CMD ["--version"]
