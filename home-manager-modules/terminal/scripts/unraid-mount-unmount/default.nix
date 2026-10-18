{
  pkgs,
  user,
}:
pkgs.writeShellApplication {
  name = "unraid";
  runtimeInputs = with pkgs; [
    cifs-utils
    coreutils
    sudo
    util-linux
  ];
  text = ''
    mount_point="$HOME/unraid"
    host="''${UNRAID_HOST:-//192.168.1.114/data}"

    mkdir -p "$mount_point"

    if mountpoint -q "$mount_point"; then
      if sudo umount "$mount_point"; then
        echo "Unmounted $mount_point"
      else
        echo "Failed to unmount $mount_point" >&2
        exit 1
      fi
    else
      if sudo mount -t cifs "$host" "$mount_point" -o "username=${user},uid=$(id -u),gid=$(id -g)"; then
        echo "Mounted $mount_point"
      else
        echo "Failed to mount $mount_point" >&2
        exit 1
      fi
    fi
  '';
}
