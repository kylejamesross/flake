{pkgs}:
pkgs.writeShellScriptBin "garmin-schedule-transfer" ''
  set -euo pipefail

  USER_HOME="/home/kyle"
  MOUNT_POINT="$USER_HOME/garmin"
  DEST_DIR="$MOUNT_POINT/GARMIN/NEWFILES"
  DEVICE=$(lsblk --list -o NAME,SIZE | awk '$2 == "54.3M" {print "/dev/" $1}')
  FILE_TO_COPY="$USER_HOME/documents/output-fit/*.fit"

  mkdir -p "$MOUNT_POINT"

  # Unmount if already mounted
  if mountpoint -q "$MOUNT_POINT"; then
    echo "Unmounting previous mount..."
    sudo umount "$MOUNT_POINT"
  fi

  echo "Mounting $DEVICE to $MOUNT_POINT..."
  sudo mount -o rw,uid=$(id -u),gid=$(id -g) "$DEVICE" "$MOUNT_POINT"

  if [[ ! -d "$DEST_DIR" ]]; then
    echo "Error: Expected Garmin directory '$DEST_DIR' not found."
    exit 1
  fi

  echo "Copying '$FILE_TO_COPY' to $DEST_DIR..."
  cp $FILE_TO_COPY "$DEST_DIR"

  sync

  echo "✅ File '$FILE_TO_COPY' copied successfully to $DEST_DIR"

  echo "Unmounting $MOUNT_POINT..."
  sudo umount "$MOUNT_POINT"
''
