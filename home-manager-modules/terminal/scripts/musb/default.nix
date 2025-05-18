{pkgs}:
pkgs.writeShellScriptBin "musb" ''
  mkdir -p ~/usb && sudo mount \"/dev/$(lsblk --list | ${pkgs.fzf}/bin/fzf | ${pkgs.gawk}/bin/awk '{print $1}')\" ~/usb
''
