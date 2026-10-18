{pkgs}:
pkgs.writeShellApplication {
  name = "wr";
  runtimeInputs = with pkgs; [
    fzf
    git
    gnused
  ];
  text = ''
    worktree=$(git worktree list --porcelain | sed -n 's/^worktree //p' | fzf || true)
    if [ -z "$worktree" ]; then
      exit 0
    fi
    git worktree remove "$worktree"
  '';
}
