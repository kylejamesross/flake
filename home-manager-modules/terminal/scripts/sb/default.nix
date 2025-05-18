{pkgs}:
pkgs.writeShellScriptBin "sb" ''
  ${pkgs.git}/bin/git branch | ${pkgs.fzf}/bin/fzf | xargs -I {} ${pkgs.git}/bin/git switch {}
''
