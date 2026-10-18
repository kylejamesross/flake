{pkgs}:
pkgs.writeShellApplication {
  name = "g";
  runtimeInputs = with pkgs; [
    nh
  ];
  text = ''
    exec nh os switch "$HOME/flake"
  '';
}
