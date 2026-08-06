{
  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        # after_sleep_cmd = "sleep 1 && hyprctl dispatch dpms on";
      };

      listener = [
        # {
        #   timeout = 150;
        #   on-timeout = "hyprctl dispatch dpms off";
        #   on-resume = "hyprctl dispatch dpms on";
        # }
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 380;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
