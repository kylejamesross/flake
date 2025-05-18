{pkgs}:
pkgs.writeShellScriptBin "swww-randomizer" ''

  wallpaper_dir="$HOME/.config/wallpapers"

  for display in $(${pkgs.wlr-randr}/bin/wlr-randr | ${pkgs.gawk}/bin/awk '/^[^ ]+ / {print $1}'); do
      random_wallpaper=$(${pkgs.fd}/bin/fd -e png -e jpg . "$wallpaper_dir" | sort -R | head -n 1)
      ${pkgs.swww}/bin/swww img -o "$display" "$random_wallpaper"
  done

''
