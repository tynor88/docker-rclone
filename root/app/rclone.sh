#!/usr/bin/with-contenv sh

(
  flock -n 200 || exit 1
  
  sleep 10
  
  if [ -z "$REMOTE_SYNC" ]; then
    echo "Error: REMOTE_SYNC environment variable was not passed to the container."
    exit 1
  else
   synccmd="rclone --config "/config/.rclone.conf" sync /data $REMOTE_SYNC:/"
   echo "Executing => $synccmd"
   eval "$synccmd"
  fi
) 200>/var/lock/rclone.lock