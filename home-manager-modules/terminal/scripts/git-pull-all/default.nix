{pkgs}:
pkgs.writeShellApplication {
  name = "git-pull-all";
  runtimeInputs = with pkgs; [
    bash
    coreutils
    fd
    git
  ];
  text = ''
    mapfile -t directories < <(fd . "$HOME/source" --min-depth 1 --max-depth 2 --type d --exec sh -c "test -e \"\$1/.git\" && echo \"\$1\"" sh {} \; || true)

    for folder in "''${directories[@]}"; do
      if git -C "$folder" pull -q; then
        echo "Git pull executed successfully for $folder"
      else
        echo "Git pull failed for $folder" >&2
      fi
    done
  '';
}
