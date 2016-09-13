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
 wget -q http://downloads.rclone.org/rclone-${RCLONE_VERSION}-linux-${ARCH}.zip && \
 unzip /tmp/rclone-${RCLONE_VERSION}-linux-${ARCH}.zip && \
 mv /tmp/rclone-*-linux-${ARCH}/rclone /usr/bin && \
 
# cleanup
 apk cache clean && \
 rm -rf \
	/tmp/* \
	/var/tmp/*

RUN unzip rclone-current-linux-amd64.zip

COPY /root /

ENTRYPOINT ["/usr/bin/rclone"]

VOLUME ["/config"]

CMD ["--version"]
