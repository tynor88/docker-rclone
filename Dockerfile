FROM alpine:latest
LABEL org.opencontainers.image.authors="tynor88 <tynor@hotmail.com>"

# global environment settings
ENV S6_ARC="x86_64"
ENV RCLONE_PLATFORM_ARCH="amd64"
ARG RCLONE_VERSION="current"

# s6 environment settings
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2
ENV S6_KEEP_ENV=1

# install packages
RUN \
	apk update && \
	apk add --no-cache \
	ca-certificates

# install build packages
RUN \
 	apk add --no-cache --virtual=build-dependencies \
	wget \
	curl \
	jq \
	unzip && \
# add s6 overlay
	S6_OVERLAY_VERSION=$(curl -s https://api.github.com/repos/just-containers/s6-overlay/releases/latest | jq -r .tag_name) && \
    echo "Latest S6 Overlay version: $S6_OVERLAY_VERSION" && \
    # Download and install the latest s6-overlay. All legacy tarballs are required.
    curl -L "https://github.com/just-containers/s6-overlay/releases/download/$S6_OVERLAY_VERSION/s6-overlay-noarch.tar.xz" -o /tmp/s6-overlay-noarch.tar.xz && \
    tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz && \
    curl -L "https://github.com/just-containers/s6-overlay/releases/download/$S6_OVERLAY_VERSION/s6-overlay-${S6_ARC}.tar.xz" -o /tmp/s6-overlay-${S6_ARC}.tar.xz && \
    tar -C / -Jxpf /tmp/s6-overlay-${S6_ARC}.tar.xz && \
	curl -L "https://github.com/just-containers/s6-overlay/releases/download/$S6_OVERLAY_VERSION/s6-overlay-symlinks-noarch.tar.xz" -o /tmp/s6-overlay-symlinks-noarch.tar.xz && \
    tar -C / -Jxpf /tmp/s6-overlay-symlinks-noarch.tar.xz && \
	curl -L "https://github.com/just-containers/s6-overlay/releases/download/$S6_OVERLAY_VERSION/s6-overlay-symlinks-arch.tar.xz" -o /tmp/s6-overlay-symlinks-arch.tar.xz && \
    tar -C / -Jxpf /tmp/s6-overlay-symlinks-arch.tar.xz && \
	curl -L "https://github.com/just-containers/s6-overlay/releases/download/$S6_OVERLAY_VERSION/syslogd-overlay-noarch.tar.xz" -o /tmp/syslogd-overlay-noarch.tar.xz && \
    tar -C / -Jxpf /tmp/syslogd-overlay-noarch.tar.xz && \
 	cd tmp && \
# add rclone
	if [ "$RCLONE_VERSION" = "current" ]; then \
		echo "RCLONE_VERSION is set to 'current'." && \
		wget -q https://downloads.rclone.org/rclone-current-linux-${RCLONE_PLATFORM_ARCH}.zip && \
		unzip /tmp/rclone-current-linux-${RCLONE_PLATFORM_ARCH}.zip; \
	else \
		echo "RCLONE_VERSION is not set to 'current'. It is set to '$RCLONE_VERSION'." && \
		wget -q https://downloads.rclone.org/v${RCLONE_VERSION}/rclone-v${RCLONE_VERSION}-linux-${RCLONE_PLATFORM_ARCH}.zip && \
		unzip /tmp/rclone-v${RCLONE_VERSION}-linux-${RCLONE_PLATFORM_ARCH}.zip; \
	fi && \
	mv /tmp/rclone-*-linux-${RCLONE_PLATFORM_ARCH}/rclone /usr/bin && \
	apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
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

ENTRYPOINT ["/init"]
