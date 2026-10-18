{pkgs}:
pkgs.writeShellApplication {
  name = "musb";
  runtimeInputs = with pkgs; [
    coreutils
    fzf
    gawk
    sudo
    util-linux
  ];
  text = ''
    device=$(lsblk -dpno NAME,SIZE,MODEL | fzf | awk '{print $1}' || true)
    if [ -z "$device" ]; then
      echo "No device selected." >&2
      exit 1
    fi
    mkdir -p "$HOME/usb"
    sudo mount "$device" "$HOME/usb"
  '';
}
