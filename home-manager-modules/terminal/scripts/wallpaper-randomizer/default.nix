{pkgs}:
pkgs.writeShellApplication {
  name = "wallpaper-randomizer";
  runtimeInputs = with pkgs; [
    coreutils
    fd
    hyprland
    jq
  ];
  text = ''
    wallpaper_dir="$HOME/.config/wallpapers"

    mapfile -t displays < <(hyprctl monitors -j | jq -r '.[].name')
    if [ "''${#displays[@]}" -eq 0 ]; then
      echo "No monitors found" >&2
      exit 1
    fi

    # Wait for hyprpaper's IPC socket (it may not be up yet on login).
    for _ in $(seq 1 40); do
      if hyprctl hyprpaper listactive >/dev/null 2>&1; then
        break
      fi
      sleep 0.25
    done

    for display in "''${displays[@]}"; do
      random_wallpaper=$(fd -e png -e jpg . "$wallpaper_dir" | shuf -n 1 || true)
      if [ -z "$random_wallpaper" ]; then
        echo "No wallpapers found in $wallpaper_dir" >&2
        exit 1
      fi
      # hyprpaper >= 0.8 removed the `preload`/`unload unused` requests; it loads
      # wallpapers on demand.
      hyprctl hyprpaper wallpaper "$display,$random_wallpaper"
    done
  '';
}
