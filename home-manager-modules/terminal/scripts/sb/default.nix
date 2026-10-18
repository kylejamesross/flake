{pkgs}:
pkgs.writeShellApplication {
  name = "sb";
  runtimeInputs = with pkgs; [
    fzf
    git
  ];
  text = ''
    branch=$(git branch --format='%(refname:short)' | fzf || true)
    if [ -z "$branch" ]; then
      exit 0
    fi
    git switch "$branch"
  '';
}
