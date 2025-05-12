{pkgs}:
pkgs.writeShellScriptBin "generate-resume-into-clipboard" ''
  ${pkgs.curl}/bin/curl -s https://gitconnected.com/v1/portfolio/kylejamesross | ${pkgs.nodejs_22}/bin/npx hackmyresume build /dev/stdin TO genResume.txt && cat genResume.txt | ${pkgs.wl-clipboard}/bin/wl-copy && rm genResume.txt
''
