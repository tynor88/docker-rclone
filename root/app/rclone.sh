#!/usr/bin/with-contenv sh

echo "Running => rclone sync /config AmazonEncrypted:/"
rclone --config "/config/.rclone.conf" sync /config AmazonEncrypted:/
echo "rclone done!"