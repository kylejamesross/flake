{pkgs}:
pkgs.writeShellScriptBin "generate-resume" ''
  ${pkgs.curl}/bin/curl -s https://gitconnected.com/v1/portfolio/kylejamesross | ${pkgs.nodejs_22}/bin/npx hackmyresume build /dev/stdin TO out/resume.all
''
