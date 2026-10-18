{pkgs}:
pkgs.writeShellApplication {
  name = "garmin-schedule-transfer";
  runtimeInputs = with pkgs; [
    coreutils
    fzf
    gawk
    sudo
    util-linux
  ];
  text = ''
    destination="$HOME/garmin"
    dest_dir="$destination/GARMIN/NEWFILES"

    mkdir -p "$destination"

    cleanup() {
      if mountpoint -q "$destination"; then
        sudo umount "$destination"
      fi
    }
    trap cleanup EXIT

    if mountpoint -q "$destination"; then
      echo "Unmounting previous mount..."
      sudo umount "$destination"
    fi

    device=$(lsblk -dpno NAME,SIZE,MODEL | fzf | awk '{print $1}' || true)
    if [ -z "$device" ]; then
      echo "No device selected." >&2
      exit 1
    fi

    echo "Mounting $device to $destination..."
    sudo mount -o rw,uid="$(id -u)",gid="$(id -g)" "$device" "$destination"

    if [ ! -d "$dest_dir" ]; then
      echo "Error: Expected Garmin directory '$dest_dir' not found." >&2
      exit 1
    fi

    shopt -s nullglob
    files=("$HOME"/documents/output-fit/*.fit)
    if [ "''${#files[@]}" -eq 0 ]; then
      echo "Error: No .fit files found in $HOME/documents/output-fit." >&2
      exit 1
    fi

    echo "Copying files to $dest_dir..."
    cp -- "''${files[@]}" "$dest_dir"
    sync
    echo "Files copied successfully to $dest_dir"
  '';
}
