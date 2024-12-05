{...}: {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "Hyprland --config /etc/greetd/hyprland.conf";
      };
    };
    vt = 7;
  };
}
