{pkgs}:
pkgs.writeShellApplication {
  name = "generate-resume-into-clipboard";
  runtimeInputs = with pkgs; [
    coreutils
    curl
    nodejs_24
    wl-clipboard
  ];
  text = ''
    tmp=$(mktemp)
    trap 'rm -f "$tmp"' EXIT

    curl -fsS https://gitconnected.com/v1/portfolio/kylejamesross \
      | npx --yes hackmyresume@1.9.0-beta build /dev/stdin TO "$tmp"
    wl-copy < "$tmp"
  '';
}
