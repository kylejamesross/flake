{pkgs}:
pkgs.writeShellScriptBin "wr" ''
  ${pkgs.git}/bin/git worktree list | awk '{print $1}' | ${pkgs.fzf}/bin/fzf | xargs -I {} ${pkgs.git}/bin/git worktree remove {}
''
