#!/usr/bin/with-contenv sh

(
  flock -n 200 || exit 1
  
  else
    synccmd="rclone sync /data $SYNC_DESTINATION:/$SYNC_DESTINATION_SUBPATH"
    echo "Executing => $synccmd"
    eval "$synccmd"
    fi
  fi
  
) 200>/var/lock/rclone.lock