{pkgs}:
pkgs.writeShellScriptBin "pb" ''
  ${pkgs.git}/bin/git branch | ${pkgs.fzf}/bin/fzf --multi | xargs -I {} ${pkgs.git}/bin/git branch -D {}
''
