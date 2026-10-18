{pkgs}:
pkgs.writeShellApplication {
  name = "pb";
  runtimeInputs = with pkgs; [
    bash
    fzf
    git
  ];
  text = ''
    mapfile -t branches < <(git branch --format='%(refname:short)' | fzf --multi || true)
    if [ "''${#branches[@]}" -eq 0 ]; then
      exit 0
    fi
    git branch -D "''${branches[@]}"
  '';
}
