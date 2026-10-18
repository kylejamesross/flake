{pkgs}:
pkgs.writeShellApplication {
  name = "gnome-terminal";
  runtimeInputs = with pkgs; [
    kitty
  ];
  text = ''
    exec kitty "$@"
  '';
}
