{pkgs}:
pkgs.writeShellScriptBin "pb" ''
  ${pkgs.git}/bin/git branch --format='%(refname:short)' | ${pkgs.fzf}/bin/fzf --multi | xargs -I {} ${pkgs.git}/bin/git branch -D {}
''
