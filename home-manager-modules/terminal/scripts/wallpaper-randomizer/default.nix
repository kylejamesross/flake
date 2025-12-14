{pkgs}:
pkgs.writeShellScriptBin "wallpaper-randomizer" ''

  wallpaper_dir="$HOME/.config/wallpapers"

  sleep 0.5

  for display in $(hyprctl monitors -j | ${pkgs.jq}/bin/jq -r '.[].name'); do
      random_wallpaper=$(${pkgs.fd}/bin/fd -e png -e jpg . "$wallpaper_dir" | sort -R | head -n 1)
      hyprctl hyprpaper preload "$random_wallpaper"
      hyprctl hyprpaper wallpaper "$display,$random_wallpaper"
      hyprctl hyprpaper unload unused
  done

''
