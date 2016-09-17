#!/usr/bin/with-contenv sh

echo "Running => rclone sync /config AmazonEncrypted:/"
rclone sync /config AmazonEncrypted:/
echo "rclone done!"