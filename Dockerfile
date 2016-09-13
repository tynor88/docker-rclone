FROM justcontainers/base-alpine
MAINTAINER tynor88 <tynor@hotmail.com>

# global environment settings
ENV RCLONE_VERSION="current"
ENV RCLONE_ARCH="amd64"

# install packages
RUN \
 apk update && \
 apk add --no-cache \
 wget \
 unzip && \
 
 cd tmp && \
 wget -q http://downloads.rclone.org/rclone-${RCLONE_VERSION}-linux-${RCLONE_ARCH}.zip && \
 unzip /tmp/rclone-${RCLONE_VERSION}-linux-${RCLONE_ARCH}.zip && \
 mv /tmp/rclone-*-linux-${RCLONE_ARCH}/rclone /usr/bin && \
 
# cleanup
 apk cache clean && \
 rm -rf \
	/tmp/* \
	/var/tmp/*

ENTRYPOINT ["/usr/bin/rclone"]

VOLUME ["/config"]

CMD ["--version"]
