{pkgs}:
pkgs.writeShellApplication {
  name = "generate-resume";
  runtimeInputs = with pkgs; [
    coreutils
    curl
    nodejs_24
  ];
  text = ''
    mkdir -p out
    curl -fsS https://gitconnected.com/v1/portfolio/kylejamesross \
      | npx --yes hackmyresume@1.9.0-beta build /dev/stdin TO out/resume.all
  '';
}
