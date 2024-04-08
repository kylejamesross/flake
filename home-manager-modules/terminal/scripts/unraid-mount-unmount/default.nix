{ pkgs, user }:

pkgs.writeShellScriptBin "unraid" ''
    mount_point="$HOME/unraid"

    if [ ! -d "$mount_point" ]; then
        mkdir -p "$mount_point"
    fi

    if grep -qs "$mount_point" /proc/mounts; then
        sudo umount "$mount_point"
    else
        sudo mount -t cifs //192.168.1.114/data "$mount_point" -o username=${user},uid=$(id -u),gid=$(id -g)
    fi
''
